## Monitor nad Respond with AWS Config
***


### Connect to linux EC2 instance 
* Change your directory to home 
```
cd
trap 'printf "\n"' DEBUG
export PS1="\n[\u@\h \W] $ "
```

### Enable AWS config to monitor S3 bucket

* Create a configuration recorder

```
aws configservice put-configuration-recorder \
--recording-group allSupported=false,includeGlobalResourceTypes=\
false,resourceTypes=AWS::S3::Bucket \
--configuration-recorder name=default,roleARN=<ConfigRoleARN>

```

* Replace `ConfigRoleARN` 

```
aws configservice put-configuration-recorder \
--recording-group allSupported=false,includeGlobalResourceTypes=\
false,resourceTypes=AWS::S3::Bucket \
--configuration-recorder name=default,roleARN=arn:aws:iam::647195558556:role/ConfigRole
```

* Create a delivery channel 

```
aws configservice put-delivery-channel \
--delivery-channel configSnapshotDeliveryProperties=\
{deliveryFrequency=Twelve_Hours},name=default,\
s3BucketName=<ConfigS3BucketName>,\
snsTopicARN=<ConfigSNSTopic>
```

* Replace the place holder

```

aws configservice put-delivery-channel \
--delivery-channel configSnapshotDeliveryProperties=\
{deliveryFrequency=Twelve_Hours},name=default,\
s3BucketName=qls-5564905-54c2e061e9f3a91b-configbucket-14zag0aoenniq,\
snsTopicARN=arn:aws:sns:us-west-2:647195558556:qls-5564905-54c2e061e9f3a91b-ConfigSNSTopic-Y7MI7BFWJ5L7

```


* Start the recorder

```
aws configservice start-configuration-recorder --configuration-recorder-name default
```


### Create and Configure Cloudwatch Event Rules


* Create the JSON files that defined the rules


* Create the 1st file
```
cat <<EOF > S3ProhibitPublicReadAccess.json
{
  "ConfigRuleName": "S3PublicReadProhibited",
  "Description": "Checks that your S3 buckets do not allow public read access. If an S3 bucket policy or bucket ACL allows public read access, the bucket is noncompliant.",
  "Scope": {
    "ComplianceResourceTypes": [
      "AWS::S3::Bucket"
    ]
  },
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}
EOF

```

* Create the second file 

```
cat <<EOF > S3ProhibitPublicWriteAccess.json
{
  "ConfigRuleName": "S3PublicWriteProhibited",
  "Description": "Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant.",
  "Scope": {
    "ComplianceResourceTypes": [
      "AWS::S3::Bucket"
    ]
  },
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}
EOF

```


* Add the new rules to AWS config 

```

aws configservice put-config-rule --config-rule file://S3ProhibitPublicReadAccess.json

```

* 2nd rule

```
aws configservice put-config-rule --config-rule file://S3ProhibitPublicWriteAccess.json
```


* Create a lambda function

```
cat lambda_function.py
```



* zip the lambda functionb
```
zip lambda_function.zip lambda_function.py
```


* Create the lambda function using the command below 

```
aws lambda create-function --function-name RemoveS3PublicAccessDemo \
--runtime "python3.6" --handler lambda_function.lambda_handler \
--zip-file fileb://lambda_function.zip \
--environment Variables={TOPIC_ARN=arn:aws:sns:us-west-2:647195558556:qls-5564905-54c2e061e9f3a91b-ConfigSNSTopic-Y7MI7BFWJ5L7} \
--role arn:aws:iam::647195558556:role/LambdaRole
```


* Output 
```
{
    "FunctionName": "RemoveS3PublicAccessDemo",
    "LastModified": "2022-03-30T11:46:59.588+0000",
    "RevisionId": "254e16d3-f331-4282-ba88-a959201980b8",
    "MemorySize": 128,
    "Environment": {
        "Variables": {
            "TOPIC_ARN": "arn:aws:sns:us-west-2:647195558556:qls-5564905-54c2e061e9f3a91b-ConfigSNSTopic-Y7MI7BFWJ5L7"
        }
    },
    "State": "Pending",
    "Version": "$LATEST",
    "Role": "arn:aws:iam::647195558556:role/LambdaRole",
    "Timeout": 3,
    "StateReason": "The function is being created.",
    "Runtime": "python3.6",
    "StateReasonCode": "Creating",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "CodeSha256": "76c10pLq7SDVhnCEso+34kNfHymTix7ZnXSxcFiWztE=",
    "Description": "",
    "CodeSize": 1116,
    "FunctionArn": "arn:aws:lambda:us-west-2:647195558556:function:RemoveS3PublicAccessDemo",
    "Handler": "lambda_function.lambda_handler"
}

```


* Create an email notification using the command below 
```
aws sns subscribe --topic-arn arn:aws:sns:us-west-2:647195558556:qls-5564905-54c2e061e9f3a91b-ConfigSNSTopic-Y7MI7BFWJ5L7 \
--protocol email --notification-endpoint tajudeen.abdulazeez@bayer.com
```



### Create CloudWatch Event


* Create a file for the clodwatch event pattern

```

cat <<EOF > CloudWatchEventPattern.json
{
  "source": [
    "aws.config"
  ],
  "detail": {
    "requestParameters": {
      "evaluations": {
        "complianceType": [
          "NON_COMPLIANT"
        ]
      }
    },
    "additionalEventData": {
      "managedRuleIdentifier": [
        "S3_BUCKET_PUBLIC_READ_PROHIBITED",
        "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
      ]
    }
  }
}
EOF

```




* Create the rule with the command below 

```

aws events put-rule --name ConfigNonCompliantS3Event --event-pattern file://CloudWatchEventPattern.json

```



* output
```
{
    "RuleArn": "arn:aws:events:us-west-2:647195558556:rule/ConfigNonCompliantS3Event"
}

```


* Add a lambda function as target rule

```
aws events put-targets --rule ConfigNonCompliantS3Event \
--targets "Id"="Target1","Arn"="<LambdaFunctionARN>" "Id"="Target2","Arn"="<ConfigSNSTopic>"

```

* replace the place holders


```
aws events put-targets --rule ConfigNonCompliantS3Event \
--targets "Id"="Target1","Arn"="arn:aws:lambda:us-west-2:647195558556:function:RemoveS3PublicAccessDemo" "Id"="Target2","Arn"="arn:aws:sns:us-west-2:647195558556:qls-5564905-54c2e061e9f3a91b-ConfigSNSTopic-Y7MI7BFWJ5L7"

```



* Give the lambda permission to trigger from the cloudwatch

```

aws lambda add-permission --function-name RemoveS3PublicAccessDemo \
--statement-id my-scheduled-event --action 'lambda:InvokeFunction' \
--principal events.amazonaws.com --source-arn arn:aws:events:us-west-2:647195558556:rule/ConfigNonCompliantS3Event

```



* View the results

```
aws configservice start-config-rules-evaluation \
--config-rule-names S3PublicReadProhibited S3PublicWriteProhibited

```









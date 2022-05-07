## Identity and Resource Based Policies
***

### View and evaluate the IAM role assigned to an EC2 instance
* Open the management consoles
* Select the EC2 instance to evaluate 
* In the viewing below the instance choose the security tab
* Under the security details, locate the IAM role and then select the `IAM Role` to view the details in a new browser.
* In the summary page, expand the policy. it should look similar as shown below
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:ListBucket"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::bucket1-226554141/file1.txt",
                "arn:aws:s3:::bucket1-226554141/file2.txt",
                "arn:aws:s3:::bucket1-226554141/file3.txt",
                "arn:aws:s3:::bucket2-226554141/file1.txt",
                "arn:aws:s3:::bucket2-226554141/file2.txt",
                "arn:aws:s3:::bucket2-226554141/file3.txt"
            ],
            "Effect": "Allow"
        }
    ]
}

```



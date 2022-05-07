## Web Server Log Analysis 
***


### Intsall and Set up Kinesis agent on webserver

* connect to the EC2 instances ( ssh or session manager)
* Install using the command below 

```
sudo yum install https://s3.amazonaws.com/streaming-data-agent/aws-kinesis-agent-latest.amzn1.noarch.rpm -y
```

* Update the kinesis agent configuration file 

```
sudo sh -c 'cat <<EOF >  /etc/aws-kinesis/agent.json
{
  "cloudwatch.endpoint": "monitoring.<AWSRegion>.amazonaws.com",
  "cloudwatch.emitMetrics": true,
  "firehose.endpoint": "firehose.<AWSRegion>.amazonaws.com",
  "flows": [
    {
      "filePattern": "/var/log/httpd/access_log",
      "deliveryStream": "<DeliveryStream>"
    }
  ]
}
EOF'

```

Replace `<AWSRegion>` and `<DeliveryStream>`  with the correct value.

```
sudo sh -c 'cat <<EOF >  /etc/aws-kinesis/agent.json
{
  "cloudwatch.endpoint": "monitoring.us-west-2.amazonaws.com",
  "cloudwatch.emitMetrics": true,
  "firehose.endpoint": "firehose.us-west-2.amazonaws.com",
  "flows": [
    {
      "filePattern": "/var/log/httpd/access_log",
      "deliveryStream": "qls-5571492-283c09e5f4f8757b-deliveryStream-NQlBLZlEZpwc"
    }
  ]
}
EOF'

```

* Start the kinesis agent manually by running the command below 

```
sudo systemctl start aws-kinesis-agent.service
```

* Check if the agent is running 

```
systemctl status aws-kinesis-agent.service
```

* to monito the content of the apache access log file, run the command below 

```
tail -f /var/log/httpd/access_log
```




### Analyze logs using athena and AWS glue 

* Set up database  using - AWS Lake Formation
* Set up crawler using AWS Glue




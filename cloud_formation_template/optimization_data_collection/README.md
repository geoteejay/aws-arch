
[OPTIMIZATION DATA COLLECTION](https://wellarchitectedlabs.com/cost/300_labs/300_optimization_data_collection/)

**Goal**
* Deploy core resources and data collection modules
* Collect optimization data in S3 bucket
* Query and analyze optimization data with Amazon Athena or visualize it with Amazon QuickSight

**Costs**
* Estimated costs should be <$5 a month for small Organization

**Permissions required**
Be able to create the below in the management account:

- IAM role and policy
- Deploy CloudFormation
Be able to create the below in a sub account where your CUR data is accessible:

- Deploy CloudFormation
- Amazon S3 Bucket
- AWS Lambda function
- IAM role and policy
- Amazon CloudWatch trigger
- Amazon Athena Table
- AWS Glue Crawler



***
## Architecting in AWS
***

### Set up development environment

**Install and activate development environment**

```
virtualenv venv
source venv/bin/activate
```

**Install ansible**

```
python -m pip install ansible
python -m pip install  paramiko
```


**Install requirements**
```
pip install -r requirements.tct
```

### Automated deployment of distributed web application using ansible playbook 
The cloud formation template used is from the [AWS well-achitected labs](https://wellarchitectedlabs.com/security/200_labs/200_automated_deployment_of_ec2_web_application/) ,and with a defense in depth approach incorporating a number of AWS security best practices.

The components created include:
- [VPC](./docs/vpc-architecture.png)
- Application load balancer
- Auto scaling group of web instances
- A role attached to the auto-scaled instances allows temporary security credentials to be used
- Instances use Systems Manager instead of SSH for administration
- Amazon Aurora serverless database cluster
- Secrets manager secret for database cluster
- AWS Key Management Service is used for key management of Aurora database
- Security groups for load balancer and web instances to restrict network traffic
- Custom CloudWatch metrics and logs for web instances
- IAM role for web instances that grants permission to Systems Manager and CloudWatch
- Instances are configured from the latest Amazon Linux 2 Amazon Machine Image at boot time using user data to install agents and configure services

[**Architecture framework**](./docs/architecture.png)

**Deploy the web application in aws using the default aws profile in your pc**
```
ansible-playbook aws_web_application_playbook.yml -i inventory.txt --ask-vault-pass
```


**Generate a custom wellachitected framework in html**
```
python generateWAFReport.py --profile acct2 --workloadid c896b2b1142f6ea8dc22874674400002 --region us-east-1
```


**Generating a XLSX spreadsheet with all questions, best practices, and improvement plan links**

```
./exportAnswersToXLSX.py --fileName ./demo.xlsx --profile acct2 --region us-east-1
```

**Exporting a workload to a JSON file**

```
./exportImportWAFR.py -f workload_output.json --exportWorkload --profile acct2 -w c896b2b1142f6ea8dc22874674400002

```

**Copying a WellArchitected Tool Review from one region to another**

```
python duplicateWAFR.py --fromaccount acct2 --toaccount acct2 --workloadid c896b2b1142f6ea8dc228746744c0000 --fromregion us-east-1 --toregion us-east-2
```

**Copying a WellArchitected Tool Review from one account to another in the same region**

```
./duplicateWAFR.py --fromaccount acct2 --toaccount acct3 --workloadid c896b2b1142f6ea8dc228746744c0000 --fromregion us-east-1 --toregion us-east-1
```

**Copying a WellArchitected Tool Review from one account to another in a different region**

```
./duplicateWAFR.py --fromaccount acct2 --toaccount acct3 --workloadid c896b2b1142f6ea8dc228746744c0000 --fromregion us-east-1 --toregion us-east-2

```


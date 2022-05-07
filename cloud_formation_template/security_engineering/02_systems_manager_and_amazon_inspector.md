## Systems Manager and Amazon Inspector 
***

### Install amazon inspector agent 

To see ec2 instances that has system manager agent running 
```
aws ssm describe-instance-information  --query "InstanceInformationList[*]"
```
From the output you should see the EC2 with the systems manager running 


### To view the system manager documentation 

```
cd
aws ssm get-document --name "AmazonInspector-ManageAWSAgent" --output text > AmazonInspector-ManageAWSAgent.doc
cat AmazonInspector-ManageAWSAgent.doc | less

```



#
export PS1="\n[\u@\h \W] $ "


#
aws ssm send-command --targets Key=tag:SecurityScan,Values=true \
--document-name "AmazonInspector-ManageAWSAgent" \
--query Command.CommandId \
--output-s3-bucket-name qls-5557762-86f81f231a9131d9-logbucket-1uc4kw50k093s

# output 
"9808ce40-0920-4667-ada0-078b55d50057"


#
aws ssm list-command-invocations --details \
--query "CommandInvocations[*].[InstanceId,DocumentName,Status]" \
--command-id 9808ce40-0920-4667-ada0-078b55d50057

# output
[
    [
        "i-0c915166cc645b327",
        "AmazonInspector-ManageAWSAgent",
        "Success"
    ],
    [
        "i-061073fc1c665275e",
        "AmazonInspector-ManageAWSAgent",
        "Success"
    ]
]



#
aws inspector create-resource-group --resource-group-tags key=SecurityScan,value=true

# output
{
    "resourceGroupArn": "arn:aws:inspector:us-west-2:210597329647:resourcegroup/0-zKlVyphp"
}


#
aws inspector create-assessment-target \
--assessment-target-name GamesDevTargetGroupCLI \
--resource-group-arn arn:aws:inspector:us-west-2:210597329647:resourcegroup/0-zKlVyphp

# output 
{
    "assessmentTargetArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4"
}


#
aws inspector list-rules-packages

# output
{
    "rulesPackageArns": [
        "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
        "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
        "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
        "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl"
    ]
}


#
aws inspector describe-rules-packages --query rulesPackages[*].[name,description] --output text --rules-package-arns arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p
aws inspector describe-rules-packages --query rulesPackages[*].[name,description] --output text --rules-package-arns arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc
aws inspector describe-rules-packages --query rulesPackages[*].[name,description] --output text --rules-package-arns arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ
aws inspector describe-rules-packages --query rulesPackages[*].[name,description] --output text --rules-package-arns arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl

# output 1
Common Vulnerabilities and Exposures    The rules in this package help verify whether the EC2 instances in your application are exposed to Common Vulnerabilities and Exposures (CVEs). Attacks can exploit unpatched vulnerabilities to compromise the confidentiality, integrity, or availability of your service or data. The CVE system provides a reference for publicly known information security vulnerabilities and exposures. For more information, see [https://cve.mitre.org/](https://cve.mitre.org/). If a particular CVE appears in one of the produced Findings at the end of a completed Inspector assessment, you can search [https://cve.mitre.org/](https://cve.mitre.org/) using the CVE's ID (for example, "CVE-2009-0021") to find detailed information about this CVE, its severity, andhow to mitigate it.

# output 2


CIS Operating System Security Configuration Benchmarks  The CIS Security Benchmarks program provides well-defined, un-biased and consensus-based industry best practices to help organizations assess and improve their security.

The rules in this package help establish a secure configuration posture for the following operating systems:

  -   Amazon Linux 2 (CIS Benchmark for Amazon Linux 2 Benchmark v1.0.0 Level 1)
  -   Amazon Linux 2 (CIS Benchmark for Amazon Linux 2 Benchmark v1.0.0 Level 2)
  -   Ubuntu Linux 18.04 LTS (CIS Benchmark for Ubuntu Linux 18.04 LTS Benchmark v1.0.0 Level 1 Server)
  -   Ubuntu Linux 18.04 LTS (CIS Benchmark for Ubuntu Linux 18.04 LTS Benchmark v1.0.0 Level 2 Server)
  -   Ubuntu Linux 18.04 LTS (CIS Benchmark for Ubuntu Linux 18.04 LTS Benchmark v1.0.0 Level 1 Workstation)
  -   Ubuntu Linux 18.04 LTS (CIS Benchmark for Ubuntu Linux 18.04 LTS Benchmark v1.0.0 Level 2 Workstation)
  -   Amazon Linux version 2015.03 (CIS benchmark v1.1.0)
  -   Windows Server 2008 R2 (CIS Benchmark for Microsoft Windows 2008 R2, v3.0.0, Level 1 Domain Controller)
  -   Windows Server 2008 R2 (CIS Benchmark for Microsoft Windows 2008 R2, v3.0.0, Level 1 Member Server Profile)
  -   Windows Server 2012 R2 (CIS Benchmark for Microsoft Windows Server 2012 R2, v2.2.0, Level 1 Member Server Profile)
  -   Windows Server 2012 R2 (CIS Benchmark for Microsoft Windows Server 2012 R2, v2.2.0, Level 1 Domain Controller Profile)
  -   Windows Server 2012 (CIS Benchmark for Microsoft Windows Server 2012 non-R2, v2.0.0, Level 1 Member Server Profile)
  -   Windows Server 2012 (CIS Benchmark for Microsoft Windows Server 2012 non-R2, v2.0.0, Level 1 Domain Controller Profile)
  -   Windows Server 2016 (CIS Benchmark for Microsoft Windows Server 2016 RTM (Release 1607), v1.1.0, Level 1 Member Server Profile)
  -   Windows Server 2016 (CIS Benchmark for Microsoft Windows Server 2016 RTM (Release 1607), v1.1.0, Level 2 Member Server Profile)
  -   Windows Server 2016 (CIS Benchmark for Microsoft Windows Server 2016 RTM (Release 1607), v1.1.0, Level 1 Domain Controller Profile)
  -   Windows Server 2016 (CIS Benchmark for Microsoft Windows Server 2016 RTM (Release 1607), v1.1.0, Level 2 Domain Controller Profile)
  -   Windows Server 2016 (CIS Benchmark for Microsoft Windows Server 2016 RTM (Release 1607), v1.1.0, Next Generation Windows Security Profile)
  -   Amazon Linux (CIS Benchmark for Amazon Linux Benchmark v2.1.0 Level 1)
  -   Amazon Linux (CIS Benchmark for Amazon Linux Benchmark v2.1.0 Level 2)
  -   CentOS Linux 7 (CIS Benchmark for CentOS Linux 7 Benchmark v2.2.0 Level 1 Server)
  -   CentOS Linux 7 (CIS Benchmark for CentOS Linux 7 Benchmark v2.2.0 Level 2 Server)
  -   CentOS Linux 7 (CIS Benchmark for CentOS Linux 7 Benchmark v2.2.0 Level 1 Workstation)
  -   CentOS Linux 7 (CIS Benchmark for CentOS Linux 7 Benchmark v2.2.0 Level 2 Workstation)
  -   Red Hat Enterprise Linux 7 (CIS Benchmark for Red Hat Enterprise Linux 7 Benchmark v2.1.1 Level 1 Server)
  -   Red Hat Enterprise Linux 7 (CIS Benchmark for Red Hat Enterprise Linux 7 Benchmark v2.1.1 Level 2 Server)
  -   Red Hat Enterprise Linux 7 (CIS Benchmark for Red Hat Enterprise Linux 7 Benchmark v2.1.1 Level 1 Workstation)
  -   Red Hat Enterprise Linux 7 (CIS Benchmark for Red Hat Enterprise Linux 7 Benchmark v2.1.1 Level 2 Workstation)
  -   Ubuntu Linux 16.04 LTS (CIS Benchmark for Ubuntu Linux 16.04 LTS Benchmark v1.1.0 Level 1 Server)
  -   Ubuntu Linux 16.04 LTS (CIS Benchmark for Ubuntu Linux 16.04 LTS Benchmark v1.1.0 Level 2 Server)
  -   Ubuntu Linux 16.04 LTS (CIS Benchmark for Ubuntu Linux 16.04 LTS Benchmark v1.1.0 Level 1 Workstation)
  -   Ubuntu Linux 16.04 LTS (CIS Benchmark for Ubuntu Linux 16.04 LTS Benchmark v1.1.0 Level 2 Workstation)
  -   CentOS Linux 6 (CIS Benchmark for CentOS Linux 6 Benchmark v2.0.2, Level 1 Server)
  -   CentOS Linux 6 (CIS Benchmark for CentOS Linux 6 Benchmark v2.0.2, Level 2 Server)
  -   CentOS Linux 6 (CIS Benchmark for CentOS Linux 6 Benchmark v2.0.2, Level 1 Workstation)
  -   CentOS Linux 6 (CIS Benchmark for CentOS Linux 6 Benchmark v2.0.2, Level 2 Workstation)
  -   Red Hat Enterprise Linux 6 (CIS Benchmark for Red Hat Enterprise Linux 6 Benchmark v2.0.2, Level 1 Server)
  -   Red Hat Enterprise Linux 6 (CIS Benchmark for Red Hat Enterprise Linux 6 Benchmark v2.0.2, Level 2 Server)
  -   Red Hat Enterprise Linux 6 (CIS Benchmark for Red Hat Enterprise Linux 6 Benchmark v2.0.2, Level 1 Workstation)
  -   Red Hat Enterprise Linux 6 (CIS Benchmark for Red Hat Enterprise Linux 6 Benchmark v2.0.2 Level 2 Workstation)
  -   Ubuntu Linux 14.04 LTS (CIS Benchmark for Ubuntu Linux 14.04 LTS Benchmark v2.0.0, Level 1 Server)
  -   Ubuntu Linux 14.04 LTS (CIS Benchmark for Ubuntu Linux 14.04 LTS Benchmark v2.0.0, Level 2 Server)
  -   Ubuntu Linux 14.04 LTS (CIS Benchmark for Ubuntu Linux 14.04 LTS Benchmark v2.0.0, Level 1 Workstation)
  -   Ubuntu Linux 14.04 LTS (CIS Benchmark for Ubuntu Linux 14.04 LTS Benchmark v2.0.0, Level 2 Workstation)

If a particular CIS benchmark appears in a finding produced by an Amazon Inspector assessment run, you can download a detailed PDF description of the benchmark from https://benchmarks.cisecurity.org/ (free registration required). The benchmark document provides detailed information about this CIS benchmark, its severity, and how to mitigate it.




# output 3
Security Best Practices The rules in this package help determine whether your systems are configured securely.


# output 4
Network Reachability    These rules analyze the reachability of your instances over the network. Attacks can exploit your instances over the network by accessing services that are listening on open ports. These rules evaluate the security your host configuration in AWS to determine if it allows access to ports and services over the network. For reachable ports and services, the Amazon Inspector findings identify where they can be reached from, and provide guidance on how to restrict access to these ports.





#
aws inspector create-assessment-template \
--assessment-target-arn arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4 \
--assessment-template-name CISCommonVulerBestPract-Short \
--duration-in-seconds 900 --rules-package-arns arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ


# output
{
    "assessmentTemplateArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw"
}


#
aws inspector preview-agents --preview-agents-arn arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw


# output 
{
    "agentPreviews": [
        {
            "kernelVersion": "4.15.0-1044-aws",
            "ipv4Address": "34.218.255.191",
            "agentHealth": "HEALTHY",
            "hostname": "ec2-34-218-255-191.us-west-2.compute.amazonaws.com",
            "agentVersion": "1.1.1712.0",
            "agentId": "i-061073fc1c665275e",
            "operatingSystem": "\"Ubuntu 18.04.2 LTS\""
        },
        {
            "kernelVersion": "4.14.268-205.500.amzn2.x86_64",
            "ipv4Address": "54.186.131.244",
            "agentHealth": "HEALTHY",
            "hostname": "ec2-54-186-131-244.us-west-2.compute.amazonaws.com",
            "agentVersion": "1.1.1712.0",
            "agentId": "i-0c915166cc645b327",
            "operatingSystem": "Amazon Linux release 2 (Karoo)"
        }
    ]
}



#
aws inspector start-assessment-run \
--assessment-run-name FirstAssessment \
--assessment-template-arn arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw


# output 

{
    "assessmentRunArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL"
}





# 
aws inspector describe-assessment-runs --assessment-run-arn arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL


# output

{
    "failedItems": {},
    "assessmentRuns": [
        {
            "dataCollected": false,
            "name": "FirstAssessment",
            "userAttributesForFindings": [],
            "stateChanges": [
                {
                    "state": "CREATED",
                    "stateChangedAt": 1648563608.108
                },
                {
                    "state": "START_DATA_COLLECTION_PENDING",
                    "stateChangedAt": 1648563608.174
                },
                {
                    "state": "COLLECTING_DATA",
                    "stateChangedAt": 1648563608.788
                }
            ],
            "createdAt": 1648563608.108,
            "notifications": [],
            "state": "COLLECTING_DATA",
            "stateChangedAt": 1648563608.788,
            "durationInSeconds": 900,
            "rulesPackageArns": [
                "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
                "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
                "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ"
            ],
            "startedAt": 1648563608.788,
            "assessmentTemplateArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw",
            "arn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL"
        }
    ]
}






#
aws inspector list-assessment-run-agents --assessment-run-arn arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL



# output 

{
    "assessmentRunAgents": [
        {
            "agentHealthCode": "RUNNING",
            "assessmentRunArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL",
            "agentId": "i-061073fc1c665275e",
            "agentHealth": "HEALTHY",
            "telemetryMetadata": [
                {
                    "count": 883,
                    "dataSize": 632252,
                    "messageType": "Total"
                },
                {
                    "count": 1,
                    "dataSize": 0,
                    "messageType": "InspectorSplitMsgBegin"
                },
                {
                    "count": 3,
                    "dataSize": 255,
                    "messageType": "InspectorTimeEventMsg"
                },
                {
                    "count": 56,
                    "dataSize": 5098,
                    "messageType": "InspectorGroup"
                },
                {
                    "count": 1,
                    "dataSize": 370,
                    "messageType": "InspectorOperatingSystem"
                },
                {
                    "count": 7,
                    "dataSize": 454944,
                    "messageType": "InspectorOvalCISMsg"
                },
                {
                    "count": 31,
                    "dataSize": 7096,
                    "messageType": "InspectorUser"
                },
                {
                    "count": 72,
                    "dataSize": 7773,
                    "messageType": "InspectorTerminal"
                },
                {
                    "count": 1,
                    "dataSize": 180,
                    "messageType": "InspectorErrorMsg"
                },
                {
                    "count": 1,
                    "dataSize": 715,
                    "messageType": "InspectorListeningProcess"
                },
                {
                    "count": 1,
                    "dataSize": 95,
                    "messageType": "InspectorMonitoringStart"
                },
                {
                    "count": 12,
                    "dataSize": 2742,
                    "messageType": "InspectorDirectoryInfoMsg"
                },
                {
                    "count": 30,
                    "dataSize": 50783,
                    "messageType": "InspectorConfigurationInfo"
                },
                {
                    "count": 667,
                    "dataSize": 102201,
                    "messageType": "InspectorPackageInfo"
                }
            ]
        },
        {
            "agentHealthCode": "RUNNING",
            "assessmentRunArn": "arn:aws:inspector:us-west-2:210597329647:target/0-ASK8xth4/template/0-yGVvf1Lw/run/0-X7muTGDL",
            "agentId": "i-0c915166cc645b327",
            "agentHealth": "HEALTHY",
            "telemetryMetadata": [
                {
                    "count": 712,
                    "dataSize": 2421517,
                    "messageType": "Total"
                },
                {
                    "count": 1,
                    "dataSize": 0,
                    "messageType": "InspectorSplitMsgBegin"
                },
                {
                    "count": 4,
                    "dataSize": 340,
                    "messageType": "InspectorTimeEventMsg"
                },
                {
                    "count": 50,
                    "dataSize": 4578,
                    "messageType": "InspectorGroup"
                },
                {
                    "count": 1,
                    "dataSize": 1458,
                    "messageType": "InspectorRetrieverCompletionStatusMsg"
                },
                {
                    "count": 1,
                    "dataSize": 391,
                    "messageType": "InspectorOperatingSystem"
                },
                {
                    "count": 36,
                    "dataSize": 2291555,
                    "messageType": "InspectorOvalCISMsg"
                },
                {
                    "count": 28,
                    "dataSize": 5979,
                    "messageType": "InspectorUser"
                },
                {
                    "count": 1,
                    "dataSize": 2834,
                    "messageType": "InspectorAgentMsgStatsMsg"
                },
                {
                    "count": 71,
                    "dataSize": 7657,
                    "messageType": "InspectorTerminal"
                },
                {
                    "count": 2,
                    "dataSize": 294,
                    "messageType": "InspectorErrorMsg"
                },
                {
                    "count": 1,
                    "dataSize": 1072,
                    "messageType": "InspectorListeningProcess"
                },
                {
                    "count": 1,
                    "dataSize": 95,
                    "messageType": "InspectorMonitoringStart"
                },
                {
                    "count": 14,
                    "dataSize": 3212,
                    "messageType": "InspectorDirectoryInfoMsg"
                },
                {
                    "count": 1,
                    "dataSize": 0,
                    "messageType": "InspectorSplitMsgEnd"
                },
                {
                    "count": 37,
                    "dataSize": 26066,
                    "messageType": "InspectorConfigurationInfo"
                },
                {
                    "count": 463,
                    "dataSize": 75986,
                    "messageType": "InspectorPackageInfo"
                }
            ]
        }
    ]
}





#
aws ssm describe-document --name "AWS-PatchInstanceWithRollback" --query "Document.[Name,Description,PlatformTypes]"

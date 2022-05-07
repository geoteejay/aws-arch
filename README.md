***
### Architecting in AWS
***

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


**GENERATE A CUSTOM WELLARCHITECTED FRAMEWORK HTML REPORT**

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


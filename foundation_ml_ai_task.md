***
### [Dataflow job](https://www.cloudskillsboost.google/focuses/1100?parent=catalog)
***
**Steps**

- activate account  `gcloud auth list`
- list project id `gcloud config list project`
- create a cloud sotorage bucket
- Install pip and the Cloud Dataflow SDK
```
docker run -it -e DEVSHELL_PROJECT_ID=$DEVSHELL_PROJECT_ID python:3.7 /bin/bash
```

- intall apache-beam `pip install apache-beam[gcp]`
- Run the wordcount.py example locally by running the following command
```
python -m apache_beam.examples.wordcount --output OUTPUT_FILE
```
- Run an Example Pipeline Remotely
```
# set the bucket path
BUCKET=gs://<bucket name provided earlier>

# run the job remotely
python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
  --runner DataflowRunner \
  --staging_location $BUCKET/staging \
  --temp_location $BUCKET/temp \
  --output $BUCKET/results/output \
  --region us-central1
```


***
### [Dataproc](https://www.cloudskillsboost.google/focuses/585?parent=catalog) 
***
**Steps**

- list active account `gcloud auth list`
- list project id `gcloud config list project`
- check permission `{project-number}-compute@developer.gserviceaccount.com` to editor
- Create a cluster
    - set the region `gcloud config set dataproc/region us-central1`
    - create a cluster called example-cluster 
        ```
        gcloud dataproc clusters create example-cluster --worker-boot-disk-size 500
        ```
- submit a job
```
gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPi \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000
```

- Update a cluster
    - To change the number of workers in the cluster to four
        ```
        gcloud dataproc clusters update example-cluster --num-workers 4
        ```
    - You can use the same command to decrease the number of worker nodes
        ```
        gcloud dataproc clusters update example-cluster --num-workers 2
        ```


***
### [Dataprep: Qwik Start](https://www.cloudskillsboost.google/focuses/584?parent=catalog)
***

**Steps**

- Create a Cloud Storage bucket in your project
- Initialize Cloud Dataprep
    - Select Navigation menu > Dataprep.
    - Check to accept the Google Dataprep Terms of Service, then click Accept.
    - Check to authorize sharing your account information with Trifacta, then click Agree and Continue.
    - Click Allow to allow Trifacta to access project data.
    - Click your student username to sign in to Cloud Dataprep by Trifacta. Your username is the Username in the left panel in your lab.
    - Click Allow to grant Cloud Dataprep access to your Google Cloud lab account.
    - Check to agree to Trifacta Terms of Service, and then click Accept.
    - Click Continue on the "First time set up" screen to create the default storage location.

- Create a flow
- Import datasets

***
### [Google Cloud Speech API: Qwik Start](https://www.cloudskillsboost.google/focuses/588?parent=catalog)
***

**Steps**

- list active accout `gcloud auth list`
- list project ID `gcloud config list project`
- Create an API Key
- export API key `export API_KEY=<YOUR_API_KEY>`
- Create your Speech API request
    - touch request.json
    - nano request.json
    - Add the following to your request.json file, using the uri value of the sample raw audio file
    ```
    {
    "config": {
        "encoding":"FLAC",
        "languageCode": "en-US"
    },
    "audio": {
        "uri":"gs://cloud-samples-tests/speech/brooklyn.flac"
    }
    }
    ```

- Call the Speech API
```
curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}"

```

- Run the following command to save the response in a result.json file:
```
curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json
```


***
### [Cloud Natural Language API: Qwik Start](https://www.cloudskillsboost.google/focuses/582?parent=catalog)
***

**Steps**

- list active project `gcloud auth list`
- list project ID `gcloud config list project`
- Create an API Key
    - Set environment variable with the project_id 
    ```
    export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
    ```
    - create a new service account to access the Natural Language API
    ```
    gcloud iam service-accounts create my-natlang-sa --display-name "my natural language service account"
    ```
    - create credentials to log in as your new service account. Create these credentials and save it as a JSON file "~/key.json" by using the following command
    ```
    gcloud iam service-accounts keys create ~/key.json \
  --iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com
    ```
    - set the GOOGLE_APPLICATION_CREDENTIALS environment variable
    ```
    export GOOGLE_APPLICATION_CREDENTIALS="/home/USER/key.json"
    ```

- Make an Entity Analysis Request
```
gcloud ml language analyze-entities --content="Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'." > result.json
```


***
### [Video Intelligence: Qwik Start](https://www.cloudskillsboost.google/focuses/603?parent=catalog)
***

**Steps**

- list active accout `gcloud auth list`
- list project ID `gcloud config list project`
- Enable the Video Intelligence API
- Set up authorization
    - create a new service account named quickstart:
    ```
    gcloud iam service-accounts create quickstart
    ```
    - Create a service account key file, replacing <your-project-123> with your Qwiklabs Project ID
    ```
    gcloud iam service-accounts keys create key.json --iam-account quickstart@<your-project-123>.iam.gserviceaccount.com
    ```
    - Now authenticate your service account, passing the location of your service account key file
    ```
    gcloud auth activate-service-account --key-file key.json
    ```
    - Obtain an authorization token using your service account
    ```
    gcloud auth print-access-token
    ```

- Make an annotate video request
    - Run this command to create a JSON request file with the following text, and save it as request.json 
    ```
    cat > request.json <<EOF
    {
    "inputUri":"gs://spls/gsp154/video/train.mp4",
    "features": [
        "LABEL_DETECTION"
    ]
    }
    EOF
    ```
    - Use curl to make a videos:annotate request passing the filename of the entity request
    ```
    curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/videos:annotate' \
    -d @request.json

    ```

    - You should now see a response that includes your operation name, which should look similar to this one:
    ```
    {
    "name": "projects/474887704060/locations/asia-east1/operations/16366331060670521152"
    }

    ```
    - Use this script to request information on the operation by calling the v1.operations endpoint. Replace the PROJECTS, LOCATIONS and OPERATION_NAME with the value you just received in the previous command

    ```
    curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/projects/PROJECTS/locations/LOCATIONS/operations/OPERATION_NAME'

    ```

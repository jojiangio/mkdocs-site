# Integrate Google Cloud with GitHub

## Download and install the Google Cloud SDK
```bash
curl -sSL https://sdk.cloud.google.com | bash
```

## Restart terminal
```bash
exec -l $SHELL
```

## Initialize
```bash
gcloud init
```

## Open a browser to log in
```bash
gcloud auth login
```

## Create a project
```bash
gcloud projects create PROJECT_ID --name="Project Name"

ex: gcloud projects create my-cloud-run-demo --name="Cloud Run Demo"
```

## Set the project as active
```bash
gcloud config set project my-cloud-run-demo
```

## List all project
```bash
gcloud projects list
```

## Enable these APIs
```bash
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable artifactregistry.googleapis.com
```

## Set Up a Service Account with Permissions
```bash
gcloud iam service-accounts create github-actions-runner --display-name "GitHub Actions Runner"

gcloud projects add-iam-policy-binding [PROJECT_ID] \
  --member="serviceAccount:github-actions-runner@[PROJECT_ID].iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding [PROJECT_ID] \
  --member="serviceAccount:github-actions-runner@[PROJECT_ID].iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding [PROJECT_ID] \
  --member="serviceAccount:github-actions-runner@[PROJECT_ID].iam.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"
```


## Generate Service Account Key
```bash
gcloud iam service-accounts keys create key.json \
  --iam-account github-actions-runner@[PROJECT_ID].iam.gserviceaccount.com
```

## Add the content of `key.json` as a Github secret

1. Copy the entire key.json contents
2. Go to the repo settings on Github
3. Click Secrets and variables → Actions
4. Add the key to New repository secret and give it a meaning name (ex: GCP_SERVICE_ACCOUNT_KEY)

## Configure the repository and deploy a Cloud Run service

Go to Google Cloud Console → Artifact Registry → Create Repository:

Name: ghcr (or any name)
Format: Docker
Location Type: Region
Location: us-central1
Description: optional
Leave Repository Type as Standard
Cleanup policies: Dry run
(Optional) Enable Public Access if you want the repo to be publicly pullable
Click Create

Click Copy path in Repository Details 

# Check service url after everything is working
```bash
gcloud run services list --platform=managed
```

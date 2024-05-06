#! /usr/bin/env zsh

svc_account_name="tf-svcacct"

# Get Project Name in env variable PROJECT_ID
grand_parent_dir=$(dirname $parent_dir)
project_dir=$(dirname $grand_parent_dir)
config_file=$project_dir/project_config.txt
source $config_file

# Create Service Account
gcloud iam service-accounts create \
  $svc_account_name \
  --display-name "Terraform Service Account"

# Add Roles bindings to Service Account
gcloud projects add-iam-policy-binding \
  $PROJECT_ID \
  --member serviceAccount:$svc_account_name@$PROJECT_ID.iam.gserviceaccount.com \
  --role roles/storage.admin

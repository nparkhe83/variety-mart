#! /usr/bin/env zsh

if [ -z $1 ]; then
  echo "Please provide the service account email address"
  exit 1
fi

project_dir=$(dirname $(dirname $(dirname ${0:a})))

source $project_dir/project_config.txt

sa_key_path=$project_dir/terraform-config/sa_key.json

# Check if the service account key file exists
if [ ! -f $sa_key_path ]; then
  echo "Service account key file not found. Creating a new one..."
  gcloud iam service-accounts keys create $sa_key_path --iam-account $1
else
  echo "Service account key file found. Using existing one..."
fi

# Login to the GCP project using the service account key
pushd $project_dir/terraform-config
cp providers.tf_SAKey providers.tf
terraform apply
popd

# use jq to read the private key id from the service account key file
key_id=$(jq -r '.private_key_id' $sa_key_path)

gcloud iam service-accounts keys delete $key_id --iam-account $1

rm $sa_key_path

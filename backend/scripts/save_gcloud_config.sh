#! /usr/bin/env zsh
function checkForConfigFile() {

  if [ ! -f $file_path ]; then
    touch $file_path

    cat <<EOF >$file_path
PROJECT_ID=variety-mart-1
BUCKET_ID=
NETWORK_NAME=
SUBNET_NAME=
REGION=asia-south1
ZONE=asia-south1-a
EOF
    print_green "File created: $file_path"
  else
    print_green "File already exists: $file_path"
  fi
}

# gcloud config authenticates to GCP and saves account details to workstation automatically,
# hence no need to fetch those details.
# We only need Project ID, Bucket ID, Network Name, and API Key.

source $(dirname $0)/utils.sh

# get absolute path of the script
script_dir=$(dirname ${0:a})
parent_dir=$(dirname $script_dir)       #'backend'
project_root_dir=$(dirname $parent_dir) #'variety-mart'

file_path=$project_root_dir/project_config.txt

checkForConfigFile

print_yellow "Update Project configuration in File"
print_yellow "Press any key to continue"
read

vi $file_path

source $file_path

gcloud config set project $PROJECT_ID
gcloud config set compute/region $REGION
gcloud config set compute/zone $ZONE

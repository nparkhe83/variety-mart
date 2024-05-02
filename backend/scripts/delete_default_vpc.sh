#! /usr/bin/env zsh

source $(dirname $0)/utils.sh

gcloud compute firewall-rules delete $(gcloud compute firewall-rules list --filter="NETWORK:default" --format="value(name)" | tr "\n" " ") &>/dev/null

# Enable Compute API if not already enabled
if [[ $(gcloud services list --format="value(config.name)" --filter="config.name=compute.googleapis.com" 2>&1) != "compute.googleapis.com" ]]; then
  print_yellow "compute.googleapis.com is not enabled. Enabling..."
  gcloud services enable compute.googleapis.com &>/dev/null
else
  print_green "compute.googleapis.com is already enabled"
fi

# Check if any VPC network exists
if
  ! gcloud compute networks list --format="value(name)" &>/dev/null
then
  print_green "No networks exist."
  return
fi

# Check if default network exists
networks=$(gcloud compute networks list --format="value(name)") &>/dev/null
if ! echo $networks | grep -E "default"; then
  print_green "No default networks exist."
  return
fi

echo -e "\nAre you sure you want to delete the default network? (yes/no) "
read response

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  gcloud compute networks delete default --quiet &>/dev/null || {
    print_red "Failed to delete network: default. Please check for errors."
  }
  print_green "Default Network deleted."
  return
fi

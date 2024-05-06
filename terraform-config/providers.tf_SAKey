terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.18.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "google" {
  region  = "asia-south1"
  project = var.project_id
  credentials = file("sa_key.json")
}

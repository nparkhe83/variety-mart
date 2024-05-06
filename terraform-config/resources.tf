resource "google_storage_bucket" "my_bucket" {
  name          = "my-unique-bucket-name-asdrgerreafge"
  location      = "US"
  force_destroy = true

  versioning {
    enabled = true
  }

}
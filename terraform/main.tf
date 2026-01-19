terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0" # Matches the version in your existing main.tf
    }
  }
}

provider "google" {
  # Infrastructure Manager can inherit the project from the environment,
  # but you can also specify it via a variable.
  project = var.project_id
}

variable "project_id" {
  type        = string
  description = "The GCP Project ID where the bucket will be created."
}

variable "bucket_name" {
  type        = string
  description = "A unique name for the GCS bucket."
    default     = "test-bucket-123456"
}

resource "google_storage_bucket" "test_bucket" {
  name                        = var.bucket_name
  location                    = "US" # Options: US, EU, ASIA
  force_destroy               = true # Allows deleting a bucket that still has files inside
  uniform_bucket_level_access = true # Recommended security setting

  storage_class = "STANDARD" # Standard storage for testing
}

output "bucket_url" {
  value       = google_storage_bucket.test_bucket.url
  description = "The base URL of the created bucket."
}
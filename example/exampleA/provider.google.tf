# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  version = "2.5.1"
  project = var.gcp_project_id
  region  = var.gcp_location
}

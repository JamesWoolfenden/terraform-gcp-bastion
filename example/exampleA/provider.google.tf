
provider "google" {
  version = "2.5.1"
  project = var.project
  region  = var.region
}

provider "google-beta" {
  version = "2.14"
  project = var.project
  region  = var.region
}

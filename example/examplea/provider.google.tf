provider "google" {
  project = var.project
  region  = var.region
}

provider "http" {
  version = "1.1"
}

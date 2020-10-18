
provider "google" {
  version = "3.43.0"
  project = var.project
  region  = var.region
}

provider "http" {
  version = "1.1"
}

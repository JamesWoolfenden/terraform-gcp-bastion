
provider google {
  version = "3.8.0"
  project = var.project
  region  = var.region
}

provider http {
  version = "1.1"
}

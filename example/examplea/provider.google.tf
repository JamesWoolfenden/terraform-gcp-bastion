
provider google {
  version = "~>3.10"
  project = var.project
  region  = var.region
}

provider http {
  version = "1.1"
}

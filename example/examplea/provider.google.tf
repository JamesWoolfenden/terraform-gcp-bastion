
provider google {
  version = "2.5.1"
  project = var.project
  region  = var.region
}

provider http {
  version = "1.1"
}

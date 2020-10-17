variable name {
  description = ""
  type        = string
}

variable project {
  description = "The GCP project your targeting, may not be where the instances exist"
  type        = string
}

variable network_interface {
  description = ""
  type        = map
}

variable zone {
  type = string
}


variable region {
  type = string

}

variable image {
  type = map
}

variable source_cidrs {
  type        = list
  description = "The ranges to allow to connect to the bastion"
}

variable service_email {
  type = string
}

variable "keyring" {
  type = string
}

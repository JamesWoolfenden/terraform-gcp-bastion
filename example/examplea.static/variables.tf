variable "name" {
  description = ""
  type        = string
}

variable "project" {
  description = "The GCP project your targeting, may not be where the instances exist"
  type        = string
}

variable "network_interface" {
  description = ""
  type        = map(any)
}

variable "zone" {
  type = string
}


variable "region" {
  type = string

}

variable "image" {
  type = map(any)

}

variable "source_cidrs" {
  type        = list(any)
  description = "The ranges to allow to connect to the bastion"
}

variable "service_email" {
  type = string
}

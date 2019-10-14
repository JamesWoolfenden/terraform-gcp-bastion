variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "subnetwork_project" {
    type = string
}

variable "zone" {
    type = string
}


variable "region" {
type=string

}

variable "image" {
type=string

}

variable "source_cidrs" {
  type        = list
  description = "The ranges to allow to connect to the bastion"
}

variable "network" {
  type        = string
  description = "The name of the vpc for the firewall to be created in"
}

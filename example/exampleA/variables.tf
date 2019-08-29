variable "name" {
}

variable "project" {
}

variable "subnetwork" {
}

variable "subnetwork_project" {
}

variable "zone" {
}


variable "region" {

}

variable "image" {

}

variable "source_cidrs" {
  type       = list
  description= "The ranges to allow to connect to the bastion"
}

variable "vpc_name" {
  type=string
  description="The name of the vpc for the firewall to be created in"
}

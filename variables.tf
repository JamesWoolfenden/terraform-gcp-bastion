variable "name" {
  type        = string
  description = "The name of the Bastion Instance"
  default     = "bastion"
}

variable "project" {
  type        = string
  description = "The GCP project"
}

variable "subnetwork" {
  type        = string
  description = "The subnet name"
}

variable "subnetwork_project" {
  type        = string
  description = ""
}

variable "zone" {
  type        = string
  description = "The GCP zone"
}

variable "machine_type" {
  type        = string
  description = "The machine type for the Bastion"
  default     = "n1-standard-1"
}

variable "tags" {
  description = ""
  type        = "list"
  default     = ["bastion"]
}

variable "image" {
  type        = string
  description = "The Base image used"
}

variable "source_cidrs" {
  type        = list
  description = "The ranges to allow to connect to the bastion"
}

variable "vpc_name" {
  type        = string
  description = "The name of the vpc for the firewall to be created in"
}

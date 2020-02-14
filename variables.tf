variable "name" {
  type        = string
  description = "The name of the Bastion Instance"
  default     = "bastion"
}

variable "project" {
  type        = string
  description = "The GCP project"
}

variable "network_interface" {
  type        = map
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
  description = "Hard-coded tags that associates the correct firewall to the instance"
  type        = list
  default     = ["bastion-ssh"]
}

variable "image" {
  type        = map
  description = "Describes the base image used"
}

variable "source_cidrs" {
  type        = list
  description = "The ranges to allow to connect to the bastion"
}

variable "firewall" {
  description = "Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up"
  type        = number
  default     = 0
}

variable "service_email" {
  description = "Service account username"
  type        = string
}

variable "service_scope" {
  type = list
  default = [
  "https://www.googleapis.com/auth/cloud-platform"]
}

variable "nat_ip" {
  description = "Values set if using a Static IP"
  default     = null
}

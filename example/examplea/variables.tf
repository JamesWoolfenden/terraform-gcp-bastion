variable "name" {
  description = "the name of the bastion host"
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name variable must not be empty."
  }
}

variable "network_interface" {
  description = "The network interface configuration for the bastion host"
  type = object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
  })
  validation {
    condition     = length(var.network_interface.network) > 0 && length(var.network_interface.subnetwork) > 0 && length(var.network_interface.subnetwork_project) > 0
    error_message = "network_interface must provide non-empty network, subnetwork and subnetwork_project."
  }
}

variable "zone" {
  description = "The zone in which to create the bastion host"
  type        = string
  validation {
    condition     = length(var.zone) > 0
    error_message = "The zone variable must not be empty."
  }
}


variable "image" {
  description = "The image to use for the bastion host"
  type = object({
    family  = string
    project = string
  })
  validation {
    condition     = length(var.image.family) > 0 && length(var.image.project) > 0
    error_message = "The image object must provide non-empty family and project."
  }
}

variable "iap_members" {
  type        = list(string)
  description = "IAM members granted roles/iap.tunnelResourceAccessor on this bastion, e.g. [\"user:alice@example.com\"]"
  validation {
    condition     = length(var.iap_members) > 0 && alltrue([for member in var.iap_members : can(regex("^(user|group|serviceAccount|domain):", member))])
    error_message = "iap_members must contain at least one IAM member, each prefixed with user:, group:, serviceAccount: or domain:."
  }
}

variable "account_id" {
  type        = string
  description = "The ID of the service account for the bastion host"
  validation {
    condition     = length(var.account_id) > 0
    error_message = "The account_id variable must not be empty."
  }
}


variable "environment" {
  type        = string
  description = "The environment for which the bastion host is being created (e.g., dev, staging, prod)"
  validation {
    condition     = length(var.environment) > 0
    error_message = "The environment variable must not be empty."
  }
}

variable "team" {
  type        = string
  description = "The team responsible for the bastion host"
  validation {
    condition     = length(var.team) > 0
    error_message = "The team variable must not be empty."
  }
}

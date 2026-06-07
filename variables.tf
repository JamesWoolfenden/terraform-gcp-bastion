variable "name" {
  type        = string
  description = "The name of the Bastion Instance"
  default     = "bastion"
  validation {
    condition     = length(var.name) > 0
    error_message = "The name variable must not be empty."
  }
}

variable "network_interface" {
  type        = map(any)
  description = "The network interface configuration for the bastion host"
  validation {
    condition     = length(var.network_interface) > 0
    error_message = "The network_interface variable must not be empty."
  }
}

variable "zone" {
  type        = string
  description = "The GCP zone"
  validation {
    condition     = length(var.zone) > 0
    error_message = "The zone variable must not be empty."
  }
}

variable "machine_type" {
  type        = string
  description = "The machine type for the Bastion"
  default     = "n1-standard-1"
  validation {
    condition     = length(var.machine_type) > 0
    error_message = "The machine_type variable must not be empty."
  }
}

variable "tags" {
  description = "Hard-coded tags that associates the correct firewall to the instance"
  type        = list(any)
  default     = ["bastion-ssh"]
  validation {
    condition     = length(var.tags) > 0
    error_message = "The tags variable must not be empty."
  }
}

variable "image" {
  type        = map(any)
  description = "Describes the base image used"
  validation {
    condition     = length(var.image) > 0
    error_message = "The image variable must not be empty."
  }
}

variable "firewall" {
  description = "Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up"
  type        = number
  default     = 0
  validation {
    condition     = var.firewall == 0 || var.firewall == 1
    error_message = "The firewall variable must be either 0 or 1."
  }
}

variable "service_scope" {
  type        = list(any)
  description = "The scopes to assign to the service account of the bastion host"
  default = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
  validation {
    condition     = length(var.service_scope) > 0
    error_message = "The service_scope variable must not be empty."
  }
}

variable "iap_members" {
  type        = list(string)
  description = "IAM members granted roles/iap.tunnelResourceAccessor on this bastion, e.g. [\"user:alice@example.com\", \"group:ops@example.com\"]. Required - with no external IP and no public SSH ingress, this is the only way anyone reaches the bastion."
  validation {
    condition     = length(var.iap_members) > 0 && alltrue([for member in var.iap_members : can(regex("^(user|group|serviceAccount|domain):", member))])
    error_message = "iap_members must contain at least one IAM member, each prefixed with user:, group:, serviceAccount: or domain:."
  }
}

variable "keyring" {
  type        = string
  default     = "pike"
  description = "The keyring to use for the bastion host"
  validation {
    condition     = length(var.keyring) > 0
    error_message = "The keyring variable must not be empty."
  }
}

variable "location" {
  type        = string
  default     = "europe-west1"
  description = "The location of the keyring and the KMS key"
  validation {
    condition     = length(var.location) > 0
    error_message = "The location variable must not be empty."
  }
}

variable "kms_key_name" {
  type        = string
  default     = "bastion"
  description = "The name of the KMS key to use for encrypting the boot disk of the bastion host"
  validation {
    condition     = length(var.kms_key_name) > 0
    error_message = "The kms_key_name variable must not be empty."
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

variable "init_script" {
  type        = string
  description = "The initialization script for the bastion host"
  validation {
    condition     = length(var.init_script) > 0
    error_message = "The init_script variable must not be empty."
  }
}

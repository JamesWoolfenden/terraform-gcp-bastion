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
  type = object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
  })
  description = "The network interface configuration for the bastion host"
  validation {
    condition = alltrue([
      length(trimspace(var.network_interface.network)) > 0,
      length(trimspace(var.network_interface.subnetwork)) > 0,
      length(trimspace(var.network_interface.subnetwork_project)) > 0,
    ])
    error_message = "The network_interface object must include non-empty network, subnetwork, and subnetwork_project values."
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
  default     = "e2-medium"
  validation {
    condition     = length(var.machine_type) > 0
    error_message = "The machine_type variable must not be empty."
  }
}

variable "tags" {
  description = "Hard-coded tags that associates the correct firewall to the instance"
  type        = list(string)
  default     = ["bastion-ssh"]
  validation {
    condition     = length(var.tags) > 0
    error_message = "The tags variable must not be empty."
  }
}

variable "image" {
  type = object({
    family  = string
    project = string
  })
  description = "Describes the base image used"
  validation {
    condition     = length(trimspace(var.image.family)) > 0 && length(trimspace(var.image.project)) > 0
    error_message = "The image object must include non-empty family and project values."
  }
}

variable "firewall" {
  description = "Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up"
  type        = bool
  default     = false
}

variable "service_scope" {
  type        = list(string)
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

variable "resource_policies" {
  type        = list(string)
  description = "Self-links of existing google_compute_resource_policy resources to attach to the bastion (e.g. an instance schedule to stop it outside working hours). The module does not own the policy's lifecycle - create it separately and pass its self_link in."
  default     = []
  validation {
    condition     = alltrue([for policy in var.resource_policies : length(trimspace(policy)) > 0])
    error_message = "resource_policies must contain only non-empty strings."
  }
}

variable "kms_key_id" {
  type        = string
  sensitive   = true
  description = "The id (self_link) of an existing google_kms_crypto_key to encrypt the bastion's boot disk with. The module does not own the key's lifecycle - create it separately (e.g. centrally-managed KMS infrastructure) and pass its id in."
  validation {
    condition     = length(var.kms_key_id) > 0
    error_message = "The kms_key_id variable must not be empty."
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

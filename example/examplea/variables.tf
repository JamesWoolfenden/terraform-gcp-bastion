variable "name" {
  description = ""
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

variable "keyring" {
  type = string
}

variable "project" {
  type        = string
  description = "(optional) describe your variable"
}

variable "account_id" {
  type        = string
  description = "(optional) describe your variable"
}

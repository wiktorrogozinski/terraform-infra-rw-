variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to be created."
}

variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "env" {
  description = "Project environment."
  type        = string
}

variable "acr_config" {
  description = "The config options."
  type        = map(any)
}

variable "as_config" {
  description = "The config options."
  type        = map(any)
}

variable "asp_config" {
  description = "The config options."
  type        = map(any)
}

variable "kv_config" {}

variable "tenant_id" {
  description = "The tenant id."
  type        = string

}

variable "identity_name" {
  description = "The name of identity."
  type        = string

}
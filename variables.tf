variable "environment_list" {
  type = list(string)
  description = "List of environments "
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "location" {
  type = string
  description = "Infrastructure's location"
}

variable "vnet_name" {
  type = string
  description = "Name of the common vnet for the project."
}

variable "backend_services_list" {
  type = list(string)
  description = "List of the identical backend services we need"
}
//PARAMETERS

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type = string
}

variable "location" {
  type = string
  description = "Infrastructure's location"
}

variable "address_space" {
  type = list(string)
  description = "The address space that is used by the virtual network."
}

variable "environment_name" {
  type = string
  description = "Environment"
}

//MODULE

variable "vnet_name" {
  type = string
  description = "Name of the front end's virtual network"
  default = "vnet_frontend"
}

variable "subnet_name" {
  type = string
  description = "Name of front end's subnet"
  default = "subnet_frontend"
}

variable "public_ip_name" {
  type = string
  description = "Name of the front end's public IP"
  default = "ip_frontend"
}

variable "sg_name" {
  type = string
  description = "Name of the front end's security group"
  default = "sg_frontend"
}

variable "network_interface_name" {
  type = string
  default = "nic_frontend"
}

variable "vm_name" {
  type = string
  description = "Name of the front end's virtual machine"
  default = "frontend"
}
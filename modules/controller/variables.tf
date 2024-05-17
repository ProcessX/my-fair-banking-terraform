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

variable "vnet_name" {
  type = string
  description = "Name of the common vnet for the project."
}

variable "ssh_key" {
  type = string
}

//MODULE

variable "subnet_name" {
  type = string
  description = "Name of the controller's subnet"
  default = "subnet_controller"
}

variable "public_ip_name" {
  type = string
  description = "Name of the controller's public IP"
  default = "ip_controller"
}

variable "environment_name" {
  type = string
  description = "Controller environment"
  default = "tools"
}

variable "sg_name" {
  type = string
  description = "Name of the controller's security group"
  default = "sg_controller"
}

variable "network_interface_name" {
  type = string
  default = "nic_controller"
}

variable "vm_name" {
  type = string
  description = "Name of the controller's virtual machine"
  default = "controller"
}
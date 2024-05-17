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



//MODULE

variable "vnet_name" {
  type = string
  description = "Name of the test's virtual network"
  default = "vnet_test"
}

variable "subnet_name" {
  type = string
  description = "Name of the test's subnet"
  default = "subnet_test"
}

variable "public_ip_name" {
  type = string
  description = "Name of the test's public IP"
  default = "ip_test"
}

variable "environment_name" {
  type = string
  description = "test environment"
  default = "test"
}

variable "sg_name" {
  type = string
  description = "Name of the test's security group"
  default = "sg_test"
}

variable "network_interface_name" {
  type = string
  default = "nic_test"
}

variable "vm_name" {
  type = string
  description = "Name of the test's virtual machine"
  default = "test"
}
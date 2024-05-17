//PARAMETERS

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type = string
}

variable "location" {
  type = string
  description = "Infrastructure's location"
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
  description = "Name of the statictest server's subnet"
  default = "subnet_statictest"
}

variable "public_ip_name" {
  type = string
  description = "Name of the statictest server's public IP"
  default = "ip_statictest"
}

variable "environment_name" {
  type = string
  description = "statictest environment"
  default = "devops"
}

variable "sg_name" {
  type = string
  description = "Name of the statictest server's security group"
  default = "sg_statictest"
}

variable "network_interface_name" {
  type = string
  default = "nic_statictest"
}

variable "vm_name" {
  type = string
  description = "Name of the statictest server's virtual machine"
  default = "statictest"
}
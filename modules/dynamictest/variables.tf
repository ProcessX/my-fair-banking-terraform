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




//MODULE


variable "subnet_name" {
  type = string
  description = "Name of the dynamictest's subnet"
  default = "subnet_dynamictest"
}

variable "public_ip_name" {
  type = string
  description = "Name of the dynamictest's public IP"
  default = "ip_dynamictest"
}

variable "environment_name" {
  type = string
  description = "dynamictest environment"
  default = "devops"
}

variable "sg_name" {
  type = string
  description = "Name of the dynamictest's security group"
  default = "sg_dynamictest"
}

variable "network_interface_name" {
  type = string
  default = "nic_dynamictest"
}

variable "vm_name" {
  type = string
  description = "Name of the dynamictest's virtual machine"
  default = "dynamictest"
}
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
  description = "Name of the monitoring server's subnet"
  default = "subnet_monitoring"
}

variable "public_ip_name" {
  type = string
  description = "Name of the monitoring server's public IP"
  default = "ip_monitoring"
}

variable "environment_name" {
  type = string
  description = "monitoring environment"
  default = "devops"
}

variable "sg_name" {
  type = string
  description = "Name of the monitoring server's security group"
  default = "sg_monitoring"
}

variable "network_interface_name" {
  type = string
  default = "nic_monitoring"
}

variable "vm_name" {
  type = string
  description = "Name of the monitoring server's virtual machine"
  default = "monitoring"
}
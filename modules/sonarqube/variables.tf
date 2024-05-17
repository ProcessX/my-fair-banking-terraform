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
  description = "Name of the sonarqube server's virtual network"
  default = "vnet_sonarqube"
}

variable "subnet_name" {
  type = string
  description = "Name of the sonarqube server's subnet"
  default = "subnet_sonarqube"
}

variable "public_ip_name" {
  type = string
  description = "Name of the sonarqube server's public IP"
  default = "ip_sonarqube"
}

variable "environment_name" {
  type = string
  description = "sonarqube environment"
  default = "sonarqube"
}

variable "sg_name" {
  type = string
  description = "Name of the sonarqube server's security group"
  default = "sg_sonarqube"
}

variable "network_interface_name" {
  type = string
  default = "nic_sonarqube"
}

variable "vm_name" {
  type = string
  description = "Name of the sonarqube server's virtual machine"
  default = "sonarqube"
}
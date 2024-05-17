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

variable "service_list" {
  type = list(string)
  description = "Name of the service to create"
}

variable "environment_name" {
  type = string
  description = "Environment"
}


variable "vnet_name" {
  type = string
  description = "Name of the front end's virtual network"
}

variable "ssh_key" {
  type = string
}

//MODULE


variable "subnet_name" {
  type = string
  description = "Name of front end's subnet"
  default = "subnet"
}

variable "public_ip_name" {
  type = string
  description = "Name of the front end's public IP"
  default = "ip"
}

variable "sg_name" {
  type = string
  description = "Name of the front end's security group"
  default = "sg"
}

variable "network_interface_name" {
  type = string
  default = "nic"
}

variable "db_name" {
  type = string
  description = "Name of the DB"
  default = "storage"
}

variable "admin_username" {
  type = string
  description = "SQL server's user name"
  default = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "The administrator password of the SQL logical server."
  sensitive   = true
  default     = null
}

variable "sql_server_name" {
  type = string
  description = "SQL server's name"
  default = "sql-server"
}

variable "address_prefixes" {
  type = list(string)
  default = [ "10.0.2.0/24"]
}

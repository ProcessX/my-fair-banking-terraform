resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = [ "10.0.0.0/16" ]
  depends_on = [ azurerm_resource_group.rg ]
}

resource "tls_private_key" "ssh_key_common" {
  algorithm = "RSA"
  rsa_bits = 4096
}

module "controller" {
  source = "./modules/controller"
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = [ "10.0.0.0/16" ]
  vnet_name = var.vnet_name
  ssh_key = tls_private_key.ssh_key_common.public_key_openssh
  depends_on = [ azurerm_resource_group.rg, azurerm_virtual_network.vnet ]
}

module "dynamictest" {
  source = "./modules/dynamictest"
  resource_group_name = var.resource_group_name
  location = var.location
  vnet_name = var.vnet_name
  depends_on = [ azurerm_resource_group.rg,azurerm_virtual_network.vnet ]
}


module "statictest" {
  source = "./modules/statictest"
  resource_group_name = var.resource_group_name
  location = var.location
  ssh_key = tls_private_key.ssh_key_common.public_key_openssh
  vnet_name = var.vnet_name
  depends_on = [ azurerm_resource_group.rg, azurerm_virtual_network.vnet ]
}

module "frontend" {
  count = length(var.environment_list)
  source = "./modules/frontend"
  resource_group_name = var.resource_group_name
  location = var.location
  vnet_name = var.vnet_name
  ssh_key = tls_private_key.ssh_key_common.public_key_openssh
  environment_name = var.environment_list[count.index]
  depends_on = [ azurerm_resource_group.rg, azurerm_virtual_network.vnet ]
}



module "backend" {
  count = length(var.environment_list)
  source = "./modules/backend"
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = [ "10.0.0.0/16" ]
  environment_name = var.environment_list[count.index]
  service_list = var.backend_services_list
  ssh_key = tls_private_key.ssh_key_common.public_key_openssh
  vnet_name = var.vnet_name
  depends_on = [ azurerm_resource_group.rg, azurerm_virtual_network.vnet]
}

module "monitoring" {
  source = "./modules/monitoring"
  resource_group_name = var.resource_group_name
  location = var.location
  ssh_key = tls_private_key.ssh_key_common.public_key_openssh
  vnet_name = var.vnet_name
  depends_on = [ azurerm_resource_group.rg, azurerm_virtual_network.vnet ]
}
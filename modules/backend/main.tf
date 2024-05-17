
resource "azurerm_subnet" "subnet" {
  count = length(var.service_list)
  name = "${var.subnet_name}_${var.service_list[count.index]}_${var.environment_name}"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes = var.address_prefixes
}

resource "azurerm_public_ip" "public_ip" {
  count = length(var.service_list)
  name = "${var.public_ip_name}_${var.service_list[count.index]}_${var.environment_name}"
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Dynamic"
  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_network_security_group" "nsg" {
  count = length(var.service_list)
  name = "${var.sg_name}_${var.service_list[count.index]}_${var.environment_name}"
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment_name
  }
}


resource "azurerm_network_interface" "nic"{
  count = length(var.service_list)
  name = "${var.network_interface_name}_${var.service_list[count.index]}_${var.environment_name}"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "nicFrontendConfig"
    subnet_id = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  count = length(var.service_list)
  network_interface_id = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

resource "random_id" "randomId" {
  count = length(var.service_list)
  keepers = {
    resource_group = var.resource_group_name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "storage" {
  count = length(var.service_list)
  name = "diag${random_id.randomId[count.index].hex}"
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment_name
  }
}
/*
data "template_file" "linux-vm-cloud-init" {
  template = file("/setup-sshconnection.sh")
  vars = {
    "ssh_key" = var.ssh_key_controller
  }
}
*/

resource "azurerm_linux_virtual_machine" "linuxvm" {
  count = length(var.service_list)
  name = "${var.service_list[count.index]}_${var.environment_name}"
  resource_group_name = var.resource_group_name
  location = var.location
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size = "Standard_DS1_v2"

  os_disk {
    name = "osDisk-${var.service_list[count.index]}-${var.environment_name}"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  computer_name = "${var.service_list[count.index]}-${var.environment_name}"
  admin_username = "azureuser"
  disable_password_authentication = true
  //custom_data = base64encode(data.template_file.linux-vm-cloud-init.rendered)

  admin_ssh_key {
    username = "azureuser"
    public_key = var.ssh_key
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage[count.index].primary_blob_endpoint
  }

  tags = {
    environment = var.environment_name
  }
}


//STORAGE
/*
resource "random_password" "admin_password" {
  length = 20
  special = true
  min_numeric = 1
  min_upper = 1
  min_lower = 1
  min_special = 1
}

locals {
  admin_password = try(random_password.admin_password.result, var.admin_password)
}



resource "azurerm_mssql_server" "server" {
  count = length(var.service_list)
  name = "${var.sql_server_name}-${var.service_list[count.index]}-${var.environment_name}"
  resource_group_name = var.resource_group_name
  location = var.location
  administrator_login = var.admin_username
  administrator_login_password = local.admin_password
  version = "12.0"
  lifecycle {
    ignore_changes = [
      minimum_tls_version,
    ]
  }
  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_mssql_database" "db" {
  count = length(var.service_list)
  name = "${var.db_name}_${var.service_list[count.index]}_${var.environment_name}"
  server_id = azurerm_mssql_server.server[count.index].id
  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_subnet" "subnet_storage" {
  count = length(var.service_list)
  name = "${var.subnet_name}_storage_${var.service_list[count.index]}_${var.environment_name}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[count.index].name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_sql_virtual_network_rule" "example" {
  count = length(var.service_list)
  name = "sqlvnetrule-${var.service_list[count.index]}-${var.environment_name}"
  resource_group_name = var.resource_group_name
  server_name = azurerm_mssql_server.server[count.index].name
  subnet_id = azurerm_subnet.subnet_storage[count.index].id
  ignore_missing_vnet_service_endpoint = true
}
*/
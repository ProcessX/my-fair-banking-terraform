
resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name = var.public_ip_name
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Dynamic"
  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_network_security_group" "nsg" {
  name = var.sg_name
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

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment_name
  }
}


resource "azurerm_network_interface" "nic"{
  name = var.network_interface_name
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "nicControllerConfig"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "random_id" "randomId" {
  keepers = {
    resource_group = var.resource_group_name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "storage" {
  name = "diag${random_id.randomId.hex}"
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_windows_virtual_machine" "windowsvm" {
  name                  = var.vm_name
  admin_username        = "azureuser"
  admin_password        = "Lucsim123@"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "osDisk-test"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  tags = {
    environment = var.environment_name
  }
}
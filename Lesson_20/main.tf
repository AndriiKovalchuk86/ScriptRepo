resource "azurerm_resource_group" "azure-terraform-test" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "akovalchuk-VPC" {
  name                = "akovalchuk-VPC"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azure-terraform-test.location
  resource_group_name = azurerm_resource_group.azure-terraform-test.name
}

resource "azurerm_subnet" "akovalchuk-SUBNET" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.azure-terraform-test.name
  virtual_network_name = azurerm_virtual_network.akovalchuk-VPC.name
  address_prefixes     = ["10.0.128.0/24"]
}

resource "azurerm_public_ip" "my_public_ip" {
  name                = "Public_IP"
  location            = azurerm_resource_group.azure-terraform-test.location
  resource_group_name = azurerm_resource_group.azure-terraform-test.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "akovalchuk-NIC" {
  name                = "myNIC"
  location            = azurerm_resource_group.azure-terraform-test.location
  resource_group_name = azurerm_resource_group.azure-terraform-test.name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.akovalchuk-SUBNET.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "SGA" {
  network_interface_id      = azurerm_network_interface.akovalchuk-NIC.id
  network_security_group_id = azurerm_network_security_group.akovalchuk-SG.id
}

resource "azurerm_windows_virtual_machine" "akovalchuk-win10pro" {
  name                = "akovalchuk-win10pro"
  resource_group_name = azurerm_resource_group.azure-terraform-test.name
  location            = azurerm_resource_group.azure-terraform-test.location
  size                = "Standard_D1_v2"
  admin_username      = "akovalchuk"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.akovalchuk-NIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h1-pro"
    version   = "latest"
  }
}
resource "azurerm_network_security_group" "akovalchuk-SG" {
  name                = "Allow_RDP"
  location            = azurerm_resource_group.azure-terraform-test.location
  resource_group_name = azurerm_resource_group.azure-terraform-test.name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

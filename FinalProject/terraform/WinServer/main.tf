resource "azurerm_resource_group" "kov-terraform" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_mysql_server" "kovmysql" {
  name                = "kov-mysqlserver"
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name

  administrator_login          = "akoval"
  administrator_login_password = "P@$$w0rd!1234"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  ssl_enforcement_enabled      = true
}

resource "azurerm_mysql_database" "kovdb" {
  name                = "akovaldb"
  resource_group_name = azurerm_resource_group.kov-terraform.name
  server_name         = azurerm_mysql_server.kovmysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  
}

resource "azurerm_mysql_firewall_rule" "dbrule" {
  name                = "dbfiewallrule"
  resource_group_name = azurerm_resource_group.kir-terraform.name
  server_name         = azurerm_mysql_server.kovmysql.name
  start_ip_address    = var.firerwall_ip
  end_ip_address      = var.firerwall_ip
}

resource "azurerm_virtual_network" "terraform-network" {
  name                = "terraform-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name
}

resource "azurerm_subnet" "terraform-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.kov-terraform.name
  virtual_network_name = azurerm_virtual_network.terraform-network.name
  address_prefixes     = ["10.0.128.0/24"]
}

resource "azurerm_public_ip" "kov-terraform-ip" {
  name                = "TerraformPublicIP"
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "kov-terraform-nsg" {
  name                = "TerraformNetworkSecurityGroup"
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name

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

resource "azurerm_network_interface" "kov-terraform-nic" {
  name                = "TerraformNIC"
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name

  ip_configuration {
    name                          = "terraform-nic-configuration"
    subnet_id                     = azurerm_subnet.terraform-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.kov-terraform-ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.kov-terraform-nic.id
  network_security_group_id = azurerm_network_security_group.kov-terraform-nsg.id
}

resource "azurerm_windows_virtual_machine" "kov-terraform" {
  name                = "Terraform-WinServer"
  location            = azurerm_resource_group.kov-terraform.location
  resource_group_name = azurerm_resource_group.kov-terraform.name
  size                = "Standard_DS1_v2"
  admin_username      = "akovalchuk"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.kov-terraform-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

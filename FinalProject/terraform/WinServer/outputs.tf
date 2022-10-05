output "resource_group_name" {
  value = azurerm_resource_group.kov-terraform.name
}

output "azurerm_windows_virtual_machine" {
  value = azurerm_windows_virtual_machine.kov-terraform.source_image_reference
}

output "public_ip" {
  value = azurerm_public_ip.kov-terraform-ip.id
}

output "azurerm_mysql_database" {
  value = azurerm_mysql_database.kovdb.server_name
}

output "azurerm_mysql_server" {
  value = azurerm_mysql_server.kovmysql.name
}

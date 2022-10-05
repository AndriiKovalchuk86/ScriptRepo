variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group"
}

variable "resource_group_name" {
  default     = "kov-serv-test-terraform"
  description = "Resourse group name"
}

variable "firerwall_ip" {
  default = "20.224.73.13"
  description = "azurerm_mysql_firewall_rule"  
}

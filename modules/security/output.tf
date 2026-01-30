output "web_nsg_id" {
value = azurerm_network_security_group.web_nsg.id
}

output "app_nsg_id" {
value = azurerm_network_security_group.app_nsg.id
}

output "db_nsg_id" {
value = azurerm_network_security_group.db_nsg.id
}


Expose subnet IDs from network module
modules/network/outputs.tf

output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

Call security module from environment
environments/dev/main.tf

module "security" {
  source = "../../modules/security"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  web_subnet_id = module.network.web_subnet_id
  app_subnet_id = module.network.app_subnet_id
  db_subnet_id  = module.network.db_subnet_id
}

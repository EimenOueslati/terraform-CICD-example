locals {
  rg_name = terraform.workspace == "default" ? "${var.rg_name}-${var.base_name}" : "${var.rg_name}-${var.base_name}-${terraform.workspace}"
}


# Resource Group for all resources
resource "azurerm_resource_group" "rg-infra" {
  name     = local.rg_name
  location = var.location
}

resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!%&*()-_=+[]{}<>:?"
}

output "vm_password" {
  value     = azurerm_key_vault_secret.vm_password.value
  sensitive = true
}


#testing workflow
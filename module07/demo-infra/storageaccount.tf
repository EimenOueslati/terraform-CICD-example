locals {
  sa_name = terraform.workspace == "default" ? "${lower(var.sa_name)}${lower(var.base_name)}${random_string.random_string.result}" : "${lower(var.sa_name)}${lower(var.base_name)}${lower(terraform.workspace)}${random_string.random_string.result}"
}

resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.rg-infra.name
  location                 = azurerm_resource_group.rg-infra.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "${lower(var.sc_name)}${lower(var.base_name)}"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
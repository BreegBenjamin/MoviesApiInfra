resource "azurerm_storage_account" "storage_account_movie" {
  name                     = "storageaccountmovie${var.environment}"
  resource_group_name      = azurerm_resource_group.movie-dev-rg.name
  location                 = azurerm_resource_group.movie-dev-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
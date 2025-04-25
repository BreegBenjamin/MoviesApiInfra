resource "azurerm_resource_group" "movie-dev-rg" {
  name     = var.resource_group_name
  location = var.regions[0]
  tags = {
    environment = var.environment
  }
}

resource "azurerm_resource_group" "movie-rg-db-rg" {
  name     = var.resource_group_db
  location = var.regions[2]
  tags = {
    environment = var.environment
  }
}
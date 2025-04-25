resource "azurerm_redis_cache" "movie_redis" {
  name                = "movie-redis-${var.environment}"
  location            = azurerm_resource_group.movie-dev-rg.location
  resource_group_name = azurerm_resource_group.movie-dev-rg.name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
}
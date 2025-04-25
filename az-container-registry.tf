
resource "azurerm_container_registry" "acr" {
  name                = "containerRegistryMovies"
  resource_group_name = azurerm_resource_group.movie-dev-rg.name
  location            = azurerm_resource_group.movie-dev-rg.location
  sku                 = "Basic" 
  admin_enabled       = true
}

resource "azurerm_role_assignment" "acr_pull_permission" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container_identity.principal_id
}


resource "azurerm_container_group" "containermoviesapp" {
  depends_on = [
    azurerm_container_registry.acr
  ]
  name                         = "movies-api-${var.environment}"
  resource_group_name          = azurerm_resource_group.movie-dev-rg.name
  location                     = azurerm_resource_group.movie-dev-rg.location
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_identity.id]
  }
  image_registry_credential {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }
  container {
    name   = "movies-api"
    image  = "containerregistrymovies.azurecr.io/app-movie:v1"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }
}
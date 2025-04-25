data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "container_identity" {
  name                = "identity-movies-app"
  resource_group_name = azurerm_resource_group.movie-dev-rg.name
  location            = azurerm_resource_group.movie-dev-rg.location
} 

resource "azurerm_key_vault" "appmoviesecuritykey" {
  name                        = "appsecuritykv${var.environment}"
  location                    = azurerm_resource_group.movie-dev-rg.location
  resource_group_name         = azurerm_resource_group.movie-dev-rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  access_policy {
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Recover"
    ]

    key_permissions = [
      "Get", "WrapKey", "UnwrapKey","List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy"

      
    ]
  }
}


resource "azurerm_key_vault_secret" "signing_key_id" {
  for_each = { for secret in var.secrets : secret.name => secret }

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.appmoviesecuritykey.id
  
}  

resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id = azurerm_key_vault.appmoviesecuritykey.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.container_identity.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]

  depends_on = [
    azurerm_user_assigned_identity.container_identity,
    azurerm_key_vault.appmoviesecuritykey
  ]
}

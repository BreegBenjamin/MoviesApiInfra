

resource "azurerm_mssql_server" "movidbmsql" {
  name                         = "movidbmsql-${var.environment}"
  resource_group_name          = azurerm_resource_group.movie-rg-db-rg.name
  location                     = azurerm_resource_group.movie-rg-db-rg.location
  version                      = "12.0"
  administrator_login          = var.userDB
  administrator_login_password = var.passwordDb
  minimum_tls_version          = "1.2"
 
}

resource "azurerm_mssql_database" "sql_database" {
  name         = "MoviesDB-${var.environment}"
  server_id    = azurerm_mssql_server.movidbmsql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "Basic"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
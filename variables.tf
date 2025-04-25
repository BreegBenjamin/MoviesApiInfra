variable "location" {
}

variable "subscription_id" {

}
variable "resource_group_name" {

}
variable "resource_group_db" {

}
variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "regions" {
  description = "List of regions for services"
  type        = list(string)
  default     = ["East US", "East US 2", "West US"]
}

variable "secrets" {
  description = "jwt secrets"
  type = list(object({
    name  = string
    value = string
  }))
  default = [ 
    {
      name  = "signing-key-issuer"
      value = "app-segurity-user"
    }, 
    {
      name  = "signing-key-value"
      value = "Z3PoYbEOEMhMEG47Rziosil2tumgCbnMtWj6GR01WsY="
    }, 
  ]
}
variable "passwordDb" {
  description = "Password for the database"
  type        = string
  default     = "password2025.*"
}
variable "userDB" {
  description = "User for the database"
  type        = string
  default     = "breegadmin01"
  
} 
resource "azurerm_resource_group" "acr" {
  name     = "rg-container-registry"
  location = var.location
  tags     = local.tags
}

resource "azurerm_container_registry" "reifnir" {
  name                = "acrreifnir"
  resource_group_name = azurerm_resource_group.acr.name
  location            = azurerm_resource_group.acr.location
  sku                 = "Basic"
  admin_enabled       = false

  tags = local.tags
}

resource "gitlab_group_variable" "AZURE_CONTAINER_REGISTRY_ID" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_CONTAINER_REGISTRY_ID"
  variable_type = "env_var"
  value         = azurerm_container_registry.reifnir.id
  protected     = false
  masked        = false
  hidden        = false
}

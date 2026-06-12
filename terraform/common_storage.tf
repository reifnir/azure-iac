resource "azurerm_resource_group" "common_storage" {
  name     = "rg-common-storage"
  location = var.location
  tags     = local.tags
}

# azurerm_storage_account.common will be destroyed
resource "azurerm_storage_account" "common" {
  name                = "sareifnircommonstorage"
  resource_group_name = azurerm_resource_group.common_storage.name
  location            = var.location

  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

  tags = local.tags
}

resource "azurerm_storage_container" "terraform_state" {
  name               = "terraform-state"
  storage_account_id = azurerm_storage_account.common.id

  # Yes it's default, but let's be explicit about it. We don't want to accidentally make this public.
  container_access_type = "private"
}


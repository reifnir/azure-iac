provider "azurerm" {
  subscription_id = var.azure_subscription
  features {}
}

provider "gitlab" {
  token = var.gitlab_token
}

terraform {
  backend "azurerm" {
    subscription_id       = "8df18e1b-269a-426f-a321-ca437966c787" # Pro MSDN subscription (no variables allowed here)
    resource_group_name  = "rg-common-storage"
    storage_account_name = "sareifnircommonstorage"
    container_name       = "terraform-state"
    key                  = "iac/terraform.tfstate"
  }

  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

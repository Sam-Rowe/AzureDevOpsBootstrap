provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/Intelion-UK"
}

terraform {
  backend "azurerm" {
  }
  required_providers {
    azuredevops = {
      source                = "terraform-providers/azuredevops"
    }
  }
}
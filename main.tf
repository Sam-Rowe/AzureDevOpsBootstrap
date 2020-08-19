provider "azuredevops" {
  version = ">= 0.0.1"
  org_service_url = "https://dev.azure.com/Intelion-UK"
  personal_access_token = "AZDO_PERSONAL_ACCESS_TOKEN"
}

resource "azuredevops_project" "test" {
  project_name       = "Terraform"
  description        = "Project Description"
}

terraform {
  backend "azurerm" {
  }
}
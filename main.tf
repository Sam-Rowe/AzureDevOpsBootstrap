resource "azuredevops_project" "test" {
  project_name = "Terraform"
  description  = "Project Description"
}

terraform {
  backend "azurerm" {
  }
  required_providers {
    azuredevops = {
      # The "hashicorp" namespace is the new home for the HashiCorp-maintained
      # provider plugins.
      #
      # source is not required for the hashicorp/* namespace as a measure of
      # backward compatibility for commonly-used providers, but recommended for
      # explicitness.
      source                = "terraform-providers/azuredevops"
      org_service_url       = "https://dev.azure.com/Intelion-UK"
      personal_access_token = "AZDO_PERSONAL_ACCESS_TOKEN"
    }
  }
}

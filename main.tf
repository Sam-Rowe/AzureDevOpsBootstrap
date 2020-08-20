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


resource "azuredevops_project" "test" {
  project_name       = "Test Project"
  description        = "Test Project Description"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"

  features = {
      "testplans" = "disabled"
      "artifacts" = "disabled"
  }
}

resource "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.test.id
  name       = "Sample Empty Git Repository"
  initialization {
    init_type = "Uninitialized"
  }
}

resource "azuredevops_user_entitlement" "admin" {
  principal_name = var.project_admin_user_email
}

data "azuredevops_group" "project_admins_group" {
  project_id = azuredevops_project.test.id
  name       = "Project Administrators"
}

resource "azuredevops_group_membership" "project_admins_membership" {
  group = data.azuredevops_group.project_admins_group.descriptor
  members = [
    azuredevops_user_entitlement.admin.descriptor
  ]
}

resource "azuredevops_serviceendpoint_azurerm" "endpointazure" {
  project_id                = azuredevops_project.test.id
  service_endpoint_name     = "AzureRM"
  azurerm_spn_tenantid      = var.tenant_id
  azurerm_subscription_id   = var.subscription_id
  azurerm_subscription_name = var.subscription_name
}

resource "azuredevops_build_definition" "build" {
  project_id = azuredevops_project.test.id
  name       = "Sample Build Definition"
  path       = "\\terraform-example"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "GitHub"
    service_connection_id = "Azure DevOps Platform"
    repo_id     = "liamfoneill/AzureDevOpsBootstrap"
    branch_name = "master"
    yml_path    = "hello-world.yml"
  }

  variable {
    name  = "PipelineVariable"
    value = "Go Microsoft!"
  }

  variable {
    name      = "PipelineSecret"
    secret_value     = "ZGV2cw"
    is_secret = true
  }
}

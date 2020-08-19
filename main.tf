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
    init_type = "Clean"
  }
}

/* resource "azuredevops_build_definition" "build" {
  project_id = azuredevops_project.test.id
  name       = "Hello World"
  path       = "\\myfirstpipeline"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "GitHub"
    repo_id     = "liamfoneill/AzureDevOpsBootstrap"
    branch_name = "master"
    yml_path    = "example-pipelines/hello-world.yml"
  }
} */

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

# Admin user
resource "azuredevops_user_entitlement" "admin" {
  principal_name = "sarowe@microsoft.com"
}

data "azuredevops_group" "group" {
  project_id = azuredevops_project.test.id
  name       = "Project Administrators"
}

resource "azuredevops_group_membership" "membership" {
  group = data.azuredevops_group.group.descriptor
  members = [
    azuredevops_user_entitlement.admin.descriptor
  ]
}
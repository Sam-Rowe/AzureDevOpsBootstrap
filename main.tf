provider "azuredevops" {
  version = ">= 0.0.1"
}

resource "azuredevops_project" "test" {
  project_name       = "Terraform"
  description        = "Project Description"
}
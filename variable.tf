variable "subscription_id" {
    type = string
}

variable "tenant_id" {
    type = string
}

variable "subscription_name" {
    type = string
}

variable "project_admin_user_email" {
    type = string
    description = "The email address of the user who will be the admin of the DevOps Project"
}

variable "repo_name" {
    type = string
    description = "The name of your Code Repository"
}

variable "work_item_template" {
    type = string
    description = "Azure DevOps Work Item Template"
    default = "Agile"
}

variable "version_control" {
    type = string
    description = "TFVC or Git"
    default = "Git"
}

variable "project_description" {
    type = string
    description = "Please enter a description for your DevOps Project"
    default = "Please enter a description for your DevOps Project"
}

variable "project_name" {
    type = string
    description = "Please enter a name for your project"
}
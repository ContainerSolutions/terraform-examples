# Summary: A simple Azure Active Directory Application

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=0.7.0"
    }
  }
}

# Azure AD Application
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application
resource "azuread_application" "changeme_simple_application" {
  name = "changeme-simple-application"
}
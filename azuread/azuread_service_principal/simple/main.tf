# Summary: A simple Azure Active Directory Service Principal

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
resource "azuread_application" "changeme_simple_service_principal_application" {
  name = "changeme-simple-azuread-service-principal-application"
}

# Azure AD Service Principal attached to the Application
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "changeme_simple_service_principal" {
  application_id = azuread_application.changeme_simple_service_principal_application.id
}
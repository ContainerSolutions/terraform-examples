# Summary: A simple Azure Active Directory Group

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

# Azure AD Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_group" "changeme_simple_group" {
  name = "changeme-simple-group-name"
}

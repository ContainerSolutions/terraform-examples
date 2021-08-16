# Summary: A simple Azure Active Directory User

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

# Azure AD User
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user
resource "azuread_user" "changeme_simple_user" {
  user_principal_name = "changeme_simple@user.com"
  display_name        = "changeme-simple-user-name"
  password            = "changeme-simple-user-password"
}

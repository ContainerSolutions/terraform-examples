# Summary: A simple Azure Active Directory Group Member assignment

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
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
resource "azuread_group" "changeme_simple_group_member_group" {
  name = "changeme-simple-group-member-group-name"
}

# Azure AD User
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user
resource "azuread_user" "changeme_simple_group_member_user" {
  user_principal_name = "changeme_simple_azuread_group_member@user.com"
  display_name        = "changeme-simple-azuread-group-member-user-name"
  password            = "changeme-simple-azuread-group-member-user-password"
}

# Azure AD Group Member assignment
# Documentation: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member
resource "azuread_group_member" "changeme_simple_group_member" {
  group_object_id  = azuread_group.changeme_simple_group_member_group.id
  member_object_id = azuread_user.changeme_simple_group_member_user.id
}

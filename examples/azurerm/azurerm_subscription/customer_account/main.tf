# Summary: A Subscription attached to an existing MCA

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "azure_subscription_id" {
  type = string
}

# Explanation: You need an existing Subscription with management rights to the MCA
# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

# Explanation: Getting the details of the existing MCA
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/billing_mca_account_scope
data "azurerm_billing_mca_account_scope" "changeme_mca_account_scope" {
  billing_account_name = "changeme_billing_account_name"
  billing_profile_name = "changeme_billing_profile_name"
  invoice_section_name = "changeme_invoice_section_name"
}

# Subscription attached to the MCA
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription
resource "azurerm_subscription" "changeme_customer_account_subscription" {
  subscription_name = "changeme-new-subscription-name"
  billing_scope_id  = data.azurerm_billing_mca_account_scope.changeme_mca_account_scope.id
}

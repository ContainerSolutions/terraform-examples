// The Azure Resource Manager provider manages Azure Cloud
provider "azurerm" {
  features {}
  version = "=2.46.0"
}

// The Azure Stack provider manages Azure Stack Hub, which is an on-prem implementation of Azure Cloud
provider "azurestack" {
  version = "=0.9.0"
}

// The Azure Active Directory manages Azure Active Directory, which is a general cloud auth solution
provider "azuread" {
  version = "=0.7.0"
}

// The Azure Devops provider manages Azure Devops, a devops environment used either as SaaS or deployed on-prem
provider "azuredevops" {
  version = ">=0.1.0"
}
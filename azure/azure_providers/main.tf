terraform {
  required_providers {
    // The Azure Active Directory manages Azure Active Directory, which is a general cloud auth solution
    // see: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
    azuread = {
      source  = "hashicorp/azuread"
      version = "=0.7.0"
    }

    // The Azure Devops provider manages Azure Devops, a devops environment used either as SaaS or deployed on-prem
    // see: https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }

    // The Azure Resource Manager provider manages most of Azure Cloud, and is also known as the Azure provider
    // https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }

    // The Azure Stack provider manages Azure Stack Hub, which is an on-prem implementation of Azure Cloud
    // see: https://registry.terraform.io/providers/hashicorp/azurestack/latest/docs
    azurestack = {
      source  = "hashicorp/azurestack"
      version = "=0.9.0"
    }
  }
}

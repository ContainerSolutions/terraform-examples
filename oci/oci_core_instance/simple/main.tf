# Summary: Creates the simplest VM instance

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~> 4.51.0"
    }
  }
}

# Oracle Cloud Infrastructure Provider
# Documentation: https://registry.terraform.io/providers/hashicorp/oci/latest/docs
provider "oci" {
}

# The OCID of the compartment
# Documentation: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance#compartment_id
variable "changeme_compartment_id" {
  type = string
}

# Subnet to create the VNIC in
# Documentation: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance#subnet_id
variable "changeme_subnet_id" {
  type = string
}

# Oracle Cloud Infrastructure Images
# https://docs.oracle.com/en-us/iaas/images/ubuntu-2004/
variable "changeme_image_id" {
  type    = string
  default = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaawlrfkqdc4fm4tco6ifgmd4pcbjg232hyo6gscvu6xcgnufdznqtq"
}

# Data source for a single Availability Domain
# Documentation: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domain
data "oci_identity_availability_domain" "changeme_availability_domain" {
  compartment_id = var.changeme_compartment_id
  ad_number      = 1
}

# Instance resource
# Documentation: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance
resource "oci_core_instance" "changeme_oci_simple_instance" {
  availability_domain = data.oci_identity_availability_domain.changeme_availability_domain.name
  compartment_id      = data.oci_identity_availability_domain.changeme_availability_domain.compartment_id
  display_name        = "changeme-oci-simple-instance"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id = var.changeme_subnet_id
  }

  source_details {
    source_type = "image"
    source_id   = var.changeme_image_id
  }

  freeform_tags = {
    cs_terraform_examples = "oci_core_instance/simple"
  }
}

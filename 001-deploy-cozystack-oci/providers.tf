terraform {
  backend "local" {}
  required_version = ">= 1.11"
  required_providers {
    oci = { source = "oracle/oci", version = "~> 6.34" }
  }
}

provider "oci" {}

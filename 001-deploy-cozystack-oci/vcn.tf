module "vcn" {
  source = "./_modules/vcn/"

  name           = "dev"
  compartment_id = var.compartment_id
  cidr_block     = "${var.vcn_network_prefix}.0.0/16"
  dns_label      = "dev"
  subnets = {
    "subnet1" = {
      cidr_block = "${var.vcn_network_prefix}.0.0/24"
    }
  }
  vlans = {
    "vlan1" = {
      cidr_block = "${var.vcn_network_prefix}.100.0/24"
      nsg_ids    = [oci_core_network_security_group.allow_all.id]
    }
  }
}

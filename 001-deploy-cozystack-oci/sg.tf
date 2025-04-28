resource "oci_core_network_security_group" "allow_all" {
  display_name   = "allow-all"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn.id
}

resource "oci_core_network_security_group_security_rule" "ingress" {
  network_security_group_id = oci_core_network_security_group.allow_all.id
  direction                 = "INGRESS"
  protocol                  = "all"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "egress" {
  network_security_group_id = oci_core_network_security_group.allow_all.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

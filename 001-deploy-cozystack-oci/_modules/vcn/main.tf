resource "oci_core_vcn" "this" {
  display_name   = var.name
  compartment_id = var.compartment_id

  cidr_block = var.cidr_block
  dns_label  = var.dns_label
}

resource "oci_core_subnet" "this" {
  for_each       = var.subnets
  display_name   = "${var.name}-${each.key}"
  cidr_block     = each.value.cidr_block
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_internet_gateway" "this" {
  display_name   = var.name
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_vcn.this.default_route_table_id

  compartment_id = var.compartment_id
  display_name   = var.name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

resource "oci_core_vlan" "this" {
  for_each       = var.vlans
  display_name   = "${var.name}-${each.key}"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  nsg_ids        = each.value.nsg_ids

  cidr_block = each.value.cidr_block
}


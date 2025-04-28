output "vlans" {
  value = oci_core_vlan.this
}

output "subnets" {
  value = oci_core_subnet.this
}

output "vcn" {
  value = oci_core_vcn.this
}

output "internet_gateway" {
  value = oci_core_internet_gateway.this
}

output "default_route_table" {
  value = oci_core_default_route_table.this
}

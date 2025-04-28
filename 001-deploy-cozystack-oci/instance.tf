resource "oci_core_instance" "dev" {
  count                                   = 3
  display_name                            = "dev-${count.index}"
  compartment_id                          = var.compartment_id
  availability_domain                     = var.availability_domain
  shape                                   = "VM.Standard3.Flex"
  preserve_boot_volume                    = false
  preserve_data_volumes_created_at_launch = false

  create_vnic_details {
    subnet_id = module.vcn.subnets.subnet1.id
    nsg_ids   = [oci_core_network_security_group.allow_all.id]
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  launch_volume_attachments {
    display_name = "dev-${count.index}"
    launch_create_volume_details {
      display_name         = "dev-${count.index}"
      compartment_id       = var.compartment_id
      size_in_gbs          = "256"
      volume_creation_type = "ATTRIBUTES"
      vpus_per_gb          = "10"
    }
    type = "paravirtualized"
  }

  shape_config {
    memory_in_gbs = "32"
    ocpus         = "4"
  }
}

resource "oci_core_vnic_attachment" "dev" {
  count       = 3
  instance_id = oci_core_instance.dev[count.index].id

  create_vnic_details {
    vlan_id = module.vcn.vlans.vlan1.id
  }
}

resource "oci_core_instance" "master" {
  display_name        = "splunk-master"
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number],"name")}"
  shape               = "${var.master_shape}"
  subnet_id           = "${oci_core_subnet.subnet.id}"

  source_details {
    source_id   = "${var.images[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id      = "${oci_core_subnet.subnet.id}"
    hostname_label = "splunk-master"
  }

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"

    user_data = "${base64encode(join("\n", list(
      "#!/usr/bin/env bash",
      file("../scripts/metadata.sh"),
      file("../scripts/disks.sh"),
      file("../scripts/master.sh")
    )))}"
  }

  extended_metadata {
    config = "${jsonencode(map(
      "shape", var.master_shape,
      "disk_count", var.master_disk_count,
      "disk_size", var.master_disk_size,
      "password", var.password,
      "sites_string", var.sites_string
    ))}"
  }
}

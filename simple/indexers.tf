resource "oci_core_instance" "indexer" {
  display_name        = "splunk-indexer-${count.index}"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number]["name"]
  shape               = var.indexer_shape
  subnet_id           = oci_core_subnet.subnet.id

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }

  create_vnic_details {
    subnet_id      = oci_core_subnet.subnet.id
    hostname_label = "splunk-indexer-${count.index}"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(
      join(
        "\n",
        [
          "#!/usr/bin/env bash",
          file("../scripts/metadata.sh"),
          file("../scripts/disks.sh"),
          file("../scripts/indexer.sh"),
        ],
      ),
    )
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"            = var.indexer_shape
        "disk_count"       = var.indexer_disk_count
        "disk_size"        = var.indexer_disk_size
        "site_string"      = element(split(",", var.sites_string), count.index)
        "count"            = count.index
        "master_public_ip" = oci_core_instance.master.public_ip
      },
    )
  }

  count = length(split(",", var.sites_string))
}


resource "oci_core_instance" "search-head" {
  display_name        = "splunk-search-head-${count.index}"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number]["name"]
  shape               = var.search_head_shape

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }

  create_vnic_details {
    subnet_id      = oci_core_subnet.subnet.id
    hostname_label = "splunk-search-head-${count.index}"
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
          file("../scripts/search_head.sh"),
        ],
      ),
    )
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"       = var.search_deployer_shape
        "role_title"  = "search_head_deployer"
        "password"    = var.password
        "shc_pass"    = var.shc_pass
        "deployer_ip" = oci_core_instance.search-deployer.public_ip
      },
    )
  }

  count = var.search_head_count
}

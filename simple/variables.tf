# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
variable "tenancy_ocid" {}

variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

# Key used to SSH to OCI VMs
variable "ssh_public_key" {}

variable "ssh_private_key" {}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# The defaults here will give you a cluster.  You can also modify these.
# ---------------------------------------------------------------------------------------------------------------------

variable "master" {
  type = "map"

  default = {
    shape = "VM.Standard2.4"

    # Number block volumes on master.
    disk_count = 1
    disk_size  = 500
  }
}

variable "indexer" {
  type = "map"

  default = {
    shape = "VM.Standard2.4"
    count = 3

    # Number block volumes on each indexer.
    disk_count = 1
    disk_size  = 500
  }
}

variable "search-head" {
  type = "map"

  default = {
    shape = "VM.Standard2.4"
    count = 4

    # Number block volumes on each search head.
    disk_count = 1
    disk_size  = 500
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Network variables
# ---------------------------------------------------------------------------------------------------------------------

variable "ad_number" {
  default     = 0
  description = "Which availability domain to deploy, zero based."
}

variable "vcn_display_name" {
  default = "testVCN"
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

# ---------------------------------------------------------------------------------------------------------------------
# Constants
# You probably don't need to change these.
# ---------------------------------------------------------------------------------------------------------------------

# Platform images
# https://docs.cloud.oracle.com/iaas/images/image/6180a2cb-be6c-4c78-a69f-38f2714e6b3d/
# Oracle-Linux-7.6-2019.05.28-0

variable "images" {
  type = "map"

  default = {
    ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa6mmih5n72yviujadzfkzthjwyc3h5uvaeejc3kpalhyakk6tfejq"
    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayxjigcwqiqjncbkm7yxppjqfzsjnbvtjsemrvnwrtpwynausossa"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaabmpm76byqi5nisxblvh4gtfvfxbnyo4vmoqfvpldggellgrv4eiq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaijslwo4cd3xhcledgwglqwjem3te4q3szekfm37hoo3wf2tm6u5a"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa66i5ug2lc6ywq6j2y4e535vgzsgb7pwn6blv2bw5a2wb2gbo5wfa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaj6pcmnh6y3hdi3ibyxhhflvp3mj2qad4nspojrnxc6pzgn2w3k5q"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa2wadtmv6j6zboncfobau7fracahvweue6dqipmcd5yj6s54f3wpq"
  }
}

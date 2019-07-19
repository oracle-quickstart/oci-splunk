output "Master server public IPs" {
  value = "${oci_core_instance.master.public_ip}"
}

output "Master server private IPs" {
  value = "${oci_core_instance.master.private_ip}"
}

output "Indexer server public IPs" {
  value = "${join(",", oci_core_instance.indexer.*.public_ip)}"
}

output "Indexer server private IPs" {
  value = "${join(",", oci_core_instance.indexer.*.private_ip)}"
}

output "Worker server public IPs" {
  value = "${join(",", oci_core_instance.search-head.*.public_ip)}"
}

output "Worker server private IPs" {
  value = "${join(",", oci_core_instance.search-head.*.private_ip)}"
}

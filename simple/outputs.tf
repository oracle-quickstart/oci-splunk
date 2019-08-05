output "Master server public IP" {
  value = "${oci_core_instance.master.public_ip}"
}

output "Master server private IP" {
  value = "${oci_core_instance.master.private_ip}"
}

output "Master server URL" {
  value = "http://${oci_core_instance.master.public_ip}:8000"
}

output "Indexer server public IPs" {
  value = "${oci_core_instance.indexer.*.public_ip}"
}

output "Indexer server private IPs" {
  value = "${oci_core_instance.indexer.*.private_ip}"
}

output "Search deployer server public IP" {
  value = "${oci_core_instance.search-deployer.public_ip}"
}

output "Search deployer server private IP" {
  value = "${oci_core_instance.search-deployer.private_ip}"
}

output "Search head server public IPs" {
  value = "${oci_core_instance.search-head.*.public_ip}"
}

output "Search head server private IPs" {
  value = "${oci_core_instance.search-head.*.private_ip}"
}

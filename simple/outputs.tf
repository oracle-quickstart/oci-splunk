output "Master_server_public_IP" {
  value = oci_core_instance.master.public_ip
}

output "Master_server_private_IP" {
  value = oci_core_instance.master.private_ip
}

output "Master_server_URL" {
  value = "http://${oci_core_instance.master.public_ip}:8000"
}

output "Indexer_server_public_IPs" {
  value = oci_core_instance.indexer.*.public_ip
}

output "Indexer_server_private_IPs" {
  value = oci_core_instance.indexer.*.private_ip
}

output "Search_deployer_server_public_IP" {
  value = oci_core_instance.search-deployer.public_ip
}

output "Search_deployer_server_private_IP" {
  value = oci_core_instance.search-deployer.private_ip
}

output "Search_head_server_public_IPs" {
  value = oci_core_instance.search-head.*.public_ip
}

output "Search_head_server_private_IPs" {
  value = oci_core_instance.search-head.*.private_ip
}


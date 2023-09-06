output "vault_ip" {
  value = docker_container.vault_container.network_data[0].ip_address
}

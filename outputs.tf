
output "ssh_key_common" {
  value = tls_private_key.ssh_key_common.private_key_pem
  sensitive = true
}

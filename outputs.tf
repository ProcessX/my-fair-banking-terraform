output "ssh_key_controller" {
  value = tls_private_key.ssh_key_controller.private_key_pem
  sensitive = true
}

output "ssh_key_controller_2" {
  value = tls_private_key.ssh_key_controller.private_key_openssh
  sensitive = true
}

output "ssh_key_controller_3" {
  value = tls_private_key.ssh_key_controller.public_key_openssh
  sensitive = true
}

output "ssh_key_backend" {
  value = tls_private_key.ssh_key_backend.private_key_pem
  sensitive = true
}

output "ssh_key_backend_2" {
  value = tls_private_key.ssh_key_backend.public_key_openssh
  sensitive = true
}

output "ssh_key_common" {
  value = tls_private_key.ssh_key_common.private_key_pem
  sensitive = true
}

output "ssh_key_common_2" {
  value = tls_private_key.ssh_key_common.public_key_openssh
  sensitive = true
}

resource "local_file" "export_public_key" {
  content    = tls_private_key.ssh_key_controller.public_key_openssh
  filename   = "public.pub"
}
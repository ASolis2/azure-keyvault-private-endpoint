output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "private_endpoint_ip" {
  value = azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address
}


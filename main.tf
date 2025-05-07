provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Data Source for Tenant ID
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "rg-keyvault-private-endpoint-001"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-kv"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
  private_endpoint_network_policies_enabled = true
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

resource "azurerm_key_vault" "kv" {
  name                     = "kvsecure${random_integer.rand.result}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  sku_name                 = "standard"
  tenant_id                = data.azurerm_client_config.current.tenant_id

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "dns-link-kv"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "pe" {
  name                = "pe-keyvault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "pe-keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "kv" {
  name                = azurerm_key_vault.kv.name
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address]
}


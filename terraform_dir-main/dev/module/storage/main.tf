# data "azurerm_resource_group" "networkds" {
#   name     = var.resource_group_name_network
# }

# data "azurerm_virtual_network" "vnetds" {
#   name                = var.virtual_network_name
#   resource_group_name = data.azurerm_resource_group.networkds.name
# }

# data "azurerm_subnet" "snet_shared_ds" {
#   name                 = var.subnet_snet_shared_ds_name
#   virtual_network_name = data.azurerm_virtual_network.vnetds.name
#   resource_group_name  = data.azurerm_resource_group.networkds.name
# }

resource "azurerm_resource_group" "storage" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
}

resource "azurerm_storage_container" "storage" {
  name                  = var.blob_storage_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "blobstorage" {
  name                   = "Blob"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.storage.name
  type                   = "Block"
  # source                 = "some-local-file.zip"
}


# resource "azurerm_private_endpoint" "endpoint_storage" {
#   name                = var.private_endpoint_storage_name
#   resource_group_name = azurerm_resource_group.storage.name
#   location            = azurerm_resource_group.storage.location
#   subnet_id           = data.azurerm_subnet.snet_shared_ds.id
#   private_service_connection {
#     name                           = var.storage_private_service_connection
#     private_connection_resource_id = azurerm_storage_account.storage.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }
# }
# resource "azurerm_private_dns_zone" "dns_zone_storage" {
#   name                = "privatelink.blob.core.windows.net"
#   resource_group_name = azurerm_resource_group.storage.name
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
#   name                  = var.storage_dns_zone_vnet_link_name
#   resource_group_name   = azurerm_resource_group.storage.name
#   private_dns_zone_name = azurerm_private_dns_zone.dns_zone_storage.name
#   virtual_network_id    = data.azurerm_virtual_network.vnetds.id
# }

# resource "azurerm_private_dns_a_record" "dns_a" {
#   name                = var.storage_dns_a_record_name
#   zone_name           = azurerm_private_dns_zone.dns_zone_storage.name
#   resource_group_name = azurerm_resource_group.storage.name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.endpoint_storage.private_service_connection.0.private_ip_address]
# }


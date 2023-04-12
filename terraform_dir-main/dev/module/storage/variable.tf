variable "resource_group_name" {}

variable "location" {}

variable "storage_account_name" {}

# variable "virtual_network_name" {}

# variable "resource_group_name_network" {}

# variable "subnet_snet_shared_ds_name" {}

# variable "private_endpoint_storage_name" {}

# variable "storage_dns_zone_vnet_link_name" {}

# variable "storage_dns_a_record_name" {}

# variable "storage_private_service_connection" {}

variable "blob_storage_name" {}

variable "container_names" {
  type = any
}
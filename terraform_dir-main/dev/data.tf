data "azurerm_resource_group" "storageds" {
  name     = var.resource_group_name
  # location = var.location
  depends_on          = [module.storage]
}

data "azurerm_resource_group" "appds" {
  name     = var.resource_group_name_app
  # location = var.location
  depends_on          = [module.app-service]
}

data "azurerm_storage_account" "storageds" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.storageds.name
  # location                 = var.location
  # account_tier             = "Standard"
  # account_replication_type = "GRS"
  depends_on          = [module.storage]
}

# data "azurerm_service_plan" "functionplan" {
#   name                = var.app_service_plan_name
#   resource_group_name = data.azurerm_resource_group.appds.name
#   # location            = azurerm_resource_group.example.location
#   # os_type             = "Windows"
#   # sku_name            = "Y1"
#   depends_on          = [module.app-service]
# }

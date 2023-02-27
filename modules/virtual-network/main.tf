resource "azurerm_virtual_network" "example" {
  name = var.virtual_network_name

  location            = var.location_name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}
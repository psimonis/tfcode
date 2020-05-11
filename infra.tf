resource azurerm_resource_group "project_rg" {
  name = "${var.project_id}-${var.environment}-${var.project_shortname}-rg"
  location = "${var.azure_location}"
}

resource  "azurerm_virtual_network" "project_vnet" {
  name                = "${var.project_id}-${var.project_shortname}-vnet"
  resource_group_name = "${azurerm_resource_group.project_rg.name}"
  address_space = [ "100.64.96.0/19" ] 
  location = "${var.azure_location}"
}
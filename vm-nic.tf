resource "azurerm_network_interface" "nic0-wan" {
  name                          = "${local.project_prefix}-server-nic0-wan"
  location                      = "${var.azure_location}"
  resource_group_name           = "${azurerm_resource_group.project_rg.name}"
  network_security_group_id     = "${azurerm_network_security_group.nsg0-wan.id}"
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${local.project_prefix}-nicconfig0-wan"
    subnet_id                     = "${azurerm_subnet.wan.id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.server_nic0_wan_private_ip}"
  }

  tags       = "${local.nic_tags}"
}

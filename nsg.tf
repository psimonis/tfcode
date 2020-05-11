resource "azurerm_network_security_group" "nsg" {
  name                = "${local.project_prefix}-nsg"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.project_rg.name}"
  tags                = "${local.nsg_tags}"
}

module "nsgrules" {
  source = "./modules/nsgrules"
  filepath = "${path.cwd}"
  environment_id = "${var.environment_id}"
  resource_group_name = "${azurerm_resource_group.project_rg.name}"
  network_security_group_name = azurerm_network_security_group.nsg.name
  azure_subscription_id = var.azure_subscription_id
}
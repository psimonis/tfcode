
# Create project vm0 public IP
resource "azurerm_public_ip" "vm0-publicip" {
  name                = "${local.project_prefix}vm0-mgmt-ip"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.project_rg.name}"
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = "${local.publicip_tags}"
}


resource "azurerm_virtual_machine" "cvcserver0" {
  name                         = "${local.project_prefix}-hamplace0"
  vm_size                      = "${var.project_vm_size}"
  location                     = "${var.azure_location}"
  resource_group_name          = "${azurerm_resource_group.project_rg.name}"
  network_interface_ids        = ["${azurerm_network_interface.nic0-wan.id}"]
  primary_network_interface_id = "${azurerm_network_interface.nic0-wan.id}"

  storage_os_disk {
    name              = "${local.project_prefix}-hamplace0-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  storage_image_reference {
    id = "${data.azurerm_image.custom.id}"
  }

  os_profile {
    computer_name  = "${local.project_prefix}-hamplace0"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_pass}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = "${merge(local.vm_tags, map("name", "${local.project_prefix}-hamplace0"))}"

}



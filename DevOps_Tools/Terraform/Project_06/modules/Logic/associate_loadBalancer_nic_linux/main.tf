/*
##########################################
Load Balancer Association
 #########################################
*/

# Association - Associate Backend Pool with the nic of the vm 
resource "azurerm_network_interface_backend_address_pool_association" "back_end_pool_nic_vm" {
  # network_interface_id    = azurerm_network_interface.nic_resource.id
  network_interface_id    = var.nic_id
  ip_configuration_name   = var.nic_ip_config_name
  backend_address_pool_id = var.frontEnd_address_public_id
}

/*
# Association - Associate Backend Pool with address of VM_APP_01
resource "azurerm_lb_backend_address_pool_address" "back_end_pool_address_VM_APP_01" {
  name                    = "BackEnd_AddressPoolAddress_VM_APP_01"
  backend_address_pool_id = azurerm_lb_backend_address_pool.back_end_address_pool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = azurerm_network_interface.nic_vm_app_01.private_ip_address
}
*/

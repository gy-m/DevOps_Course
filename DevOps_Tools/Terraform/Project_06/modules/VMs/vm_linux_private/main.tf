/*
#######################################
 DB Servers (Linux)
 ######################################
*/

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm_resource" {
  for_each                  = toset(var.vm_name)  
  name                      = each.value
  resource_group_name       = var.resourse_group_name
  location                  = var.location
  vm_size                   = "Standard_DS1_v2"
  network_interface_ids     = [azurerm_network_interface.nic_resource[each.key].id]
  zones                     = [ "2" ]

  storage_os_disk {
    name              = "Disk-${each.key}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "DB-Disk"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


/*
# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm_db" {
  name                  = "VM-DB"
  location              = "Germany West Central"
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic_vm_db.id]
  vm_size               = "Standard_DS1_v2"
  zones = [ "2" ]

  storage_os_disk {
    name              = "DB-Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "DB-Disk"
    admin_username = var.admin_username_VM_DB
    admin_password = var.admin_password_VM_DB
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
*/


/*
##########################################
 Network Interfaces (NIC)
 #########################################
*/

# Create network interface for VM-APP-01
resource "azurerm_network_interface" "nic_resource" {
  for_each                  = toset(var.vm_name)
  name                      = format("NIC-%s",each.value)
  resource_group_name       = var.resourse_group_name
  location                  = var.location

  ip_configuration {
    name                          = "NIC_VM_Linux_config"
    subnet_id                     = var.subnet_private_id
    private_ip_address_allocation = "dynamic"
    # We do not give a public address, because this vm will be on a private subnet
    # public_ip_address_id        = azurerm_public_ip.publicip_vm_app.id
  }
}
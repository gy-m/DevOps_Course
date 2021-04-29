/*
#######################################
 App Servers (Windows)
 
 Notes:
 There are 2 types of VMs for windows:
1. azurerm_virtual_machine - This type does support attaching existing OS disks (old type)
2. azurerm_windows_virtual_machine - This type does not support attaching existing OS disks (new type)
 ######################################
*/

resource "azurerm_virtual_machine" "vm_resource" {
  for_each                  = toset(var.vm_name)  
  name                      = each.value
  resource_group_name       = var.resourse_group_name
  location                  = var.location
  vm_size                   = "Standard_DS1_v2"
  network_interface_ids     = [azurerm_network_interface.nic_resource[each.key].id]
  zones                     = [var.vm_zones]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name                 = "Disk-${each.key}"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = "StandardSSD_LRS"
  }
  
  os_profile {
    computer_name  = each.value
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_windows_config {
  }

}


# TODO - Fix it so I would reference to remote image (storage_os_disk)
/*
# Create a Windows virtual machine - this type does support attaching existing OS disks
resource "azurerm_virtual_machine" "vm_app" {
  name                = "VM-APP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "Germany West Central"
  vm_size             = "Standard_DS1_v2"
  network_interface_ids = [
    azurerm_network_interface.nic_vm_app.id,
  ]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  # storage_os_disk {
  #   name                 = "APP-Disk"
  #   create_option        = "Attach"
  #   managed_disk_id      = "/subscriptions/dc5520ef-156e-4f2c-ab93-4d4f389bb82a/resourceGroups/Project_03/providers/Microsoft.Compute/disks/VM-APP_OsDisk_1_ccddc4119e894d7f9c814056d1fb45b6"
  #   # managed_disk_id    = "/subscriptions/dc5520ef-156e-4f2c-ab93-4d4f389bb82a/resourceGroups/Referene_Components/providers/Microsoft.Compute/snapshots/Ref_OsDisk_APP"
  # }
  
  
  storage_os_disk {
    name                 = "APP-Disk"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = "StandardSSD_LRS"
  }
  
 
  os_profile {
    computer_name  = "VM-APP"
    admin_username = var.admin_username_VM_APP
    admin_password = var.admin_password_VM_APP
  }
  os_profile_windows_config {
  }
}
*/


# This is a newer type, but does not support attaching an image
/*
resource "azurerm_windows_virtual_machine" "vm_app" {
  name                = "VM-APP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "Germany West Central"
  size                = "Standard_DS1_v2"
  admin_username      = var.admin_username_VM_APP
  admin_password      = var.admin_password_VM_APP
  network_interface_ids = [
    azurerm_network_interface.nic_vm_app.id,
  ]

  os_disk {
    name                 = "APP-Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
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
    name                          = "NIC_VM_Windows_config"
    subnet_id                     = var.subnet_public_id
    # subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "dynamic"
    # We do not give a public address, because the load balancer weill get it so the access from public will be throught the Load balancer
    # public_ip_address_id        = azurerm_public_ip.publicip_vm_app.id
  }
}
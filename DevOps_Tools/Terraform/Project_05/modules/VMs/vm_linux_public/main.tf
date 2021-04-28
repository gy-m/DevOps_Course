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

  storage_os_disk {
    name              = "Disk-${each.key}"
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
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

/*
##########################################
 Public IP address For every VM
 #########################################
*/

# Create public IP for LB-GW (Load Balancer)
resource "azurerm_public_ip" "public_ip_resource" {
  for_each                = toset(var.vm_name)  
  name                    = format("IP-%s",each.value)
  resource_group_name     = var.resourse_group_name
  location                = var.location
  allocation_method       = "Static"
  sku                     = "Standard"
}


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
    # name                          = format("IPconfig-%s",each.value)
    subnet_id                     = var.subnet_public_id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_resource[each.key].id
  }
}
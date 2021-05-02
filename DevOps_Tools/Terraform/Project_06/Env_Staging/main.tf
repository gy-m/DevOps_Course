############################## Providers ####################################

# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

# provider block - of the plattform and the authentication details
provider "azurerm" {
  # subscription_id = "3e4e1494-fbaa-48af-aee4-06a56b9488a6"
  features {
  }
}

################################# Main #######################################

module "Resource_Groups" {
  source                  = "../Modules/Resource_Groups"
  resourse_group_name     = "Project_06_Staging"
  resourse_group_location = var.location
}

module "network_type_01" {
  source                       = "../Modules/Networks/network_type_01"
  resourse_group_name          = module.Resource_Groups.resourse_group_name
  location                     = var.location
  vnet_address_space           = ["10.0.0.0/27"]
  subnet_prefix_public         = ["10.0.0.0/28"]
  subnet_prefix_private        = ["10.0.0.16/28"]
  load_balancer_gw_name        = "LB_GW"
  load_balancer_middle_name    = "LB_Middle"
}
 
module "vm_windows_public" {
  source                  = "../Modules/VMs/vm_windows_public"
  resourse_group_name     = module.Resource_Groups.resourse_group_name
  location                = var.location
  vm_name                 = var.vm_name_windows
  vm_zones                = "1"
  admin_username          = var.admin_username_VM_APP
  admin_password          = var.admin_password_VM_APP
  subnet_public_id        = module.network_type_01.subnet_public_id  
}

module "associate_loadBalancer_nic_linux" {
  for_each                    = toset(var.vm_name_linux)
  source                      = "../Modules/Logic/associate_loadBalancer_nic_linux"
  resourse_group_name         = module.Resource_Groups.resourse_group_name
  location                    = var.location
  frontEnd_address_public_id  = module.network_type_01.back_end_address_pool_lb_gw_id
}


module "vm_linux_private" {
  source                  = "../Modules/VMs/vm_linux_private"
  resourse_group_name     = module.Resource_Groups.resourse_group_name
  location                = var.location
  vm_name                 = var.vm_name_linux
  vm_zones                = "2"
  admin_username          = var.admin_username_VM_DB
  admin_password          = var.admin_password_VM_DB
  subnet_private_id       = module.network_type_01.subnet_private_id  
}


module "associate_loadBalancer_nic_linux" {
  for_each                    = toset(var.vm_name_linux)
  source                      = "../Modules/Logic/associate_loadBalancer_nic_linux"
  resourse_group_name         = module.Resource_Groups.resourse_group_name
  location                    = var.location
  nic_id                      = (module.vm_linux_private.nic_resource)[each.value].id
  nic_ip_config_name          = (module.vm_linux_private.nic_resource)[each.value].ip_configuration[0].name
  frontEnd_address_public_id  = module.network_type_01.back_end_address_pool_lb_middle_id
}

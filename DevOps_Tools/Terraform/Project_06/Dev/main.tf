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
  features {}
}

################################# Main #######################################

module "Resource_Groups" {
  source                  = "../Modules/Resource_Groups"
  resourse_group_name     = "Project_05"
  resourse_group_location = var.location
}

module "network_type_02" {
  source                       = "../Modules/Networks/network_type_02"
  resourse_group_name          = module.Resource_Groups.resourse_group_name
  location                     = var.location
  vnet_address_space           = ["10.0.0.0/27"]
  subnet_prefix_public         = ["10.0.0.0/28"]
  subnet_prefix_private        = ["10.0.0.16/28"]
}

module "vm_windows_public" {
  source                  = "../Modules/VMs/vm_windows_public"
  resourse_group_name     = module.Resource_Groups.resourse_group_name
  location                = var.location
  vm_name                 = var.vm_name_windows_public
  vm_zones                = "1"
  admin_username          = var.admin_username_VM_APP
  admin_password          = var.admin_password_VM_APP
  subnet_public_id        = module.network_type_02.subnet_public_id  
}

module "vm_linux_public" {
  source                  = "../Modules/VMs/vm_linux_public"
  resourse_group_name     = module.Resource_Groups.resourse_group_name
  location                = var.location
  vm_name                 = var.vm_name_linux_public
  vm_zones                = "1"
  admin_username          = var.admin_username_VM_APP
  admin_password          = var.admin_password_VM_APP
  subnet_public_id        = module.network_type_02.subnet_public_id  
}

module "vm_linux_private" {
  source                  = "../Modules/VMs/vm_linux_private"
  resourse_group_name     = module.Resource_Groups.resourse_group_name
  location                = var.location
  vm_name                 = var.vm_name_linux_private
  vm_zones                = "2"
  admin_username          = var.admin_username_VM_DB
  admin_password          = var.admin_password_VM_DB
  subnet_private_id       = module.network_type_02.subnet_private_id  
}

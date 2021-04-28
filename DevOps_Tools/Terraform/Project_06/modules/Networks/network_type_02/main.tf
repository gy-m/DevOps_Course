/*
#######################################
 Virtual Networks 
 ######################################
*/
resource "azurerm_virtual_network" "vnet" {
    name                = "Project_VNet"
    resource_group_name = var.resourse_group_name
    address_space       = var.vnet_address_space
    location            = var.location
}

/*
#######################################
 Subnets 
 ######################################
*/

# Create subnet - public (it is sub resource of VNet)
resource "azurerm_subnet" "subnet_public" {
  name                    = "Subnet_Public"
  resource_group_name     = var.resourse_group_name
  virtual_network_name    = azurerm_virtual_network.vnet.name
  address_prefixes        = var.subnet_prefix_public
}

# Create subnet - private (it is sub resource of VNet)
resource "azurerm_subnet" "subnet_private" {
  name                    = "Subnet_Private"
  resource_group_name     = var.resourse_group_name
  virtual_network_name    = azurerm_virtual_network.vnet.name
  address_prefixes        = var.subnet_prefix_private
}


/*
#######################################
 Network security groups 
 ######################################
*/

# Create Network Security Group and rule - For public subnet
resource "azurerm_network_security_group" "nsg_public" {
  name                    = "NSG_Public"
  location                = var.location
  resource_group_name     = var.resourse_group_name

  security_rule {
    direction                   = "Inbound"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range      = "3389"
    protocol                    = "Tcp"
    access                      = "Allow"
    priority                    = 100
    name                        = "Inbound_AllowRDP"
    description                 = "Accessing to the VM-APP using RDP"
  }

  security_rule {
    direction                  = "Inbound"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range     = "8080"
    protocol                   = "Tcp"
    access                     = "Allow"
    priority                   = 110
    name                       = "Inbound_Allow_TCP_8080"
    description                = "Accessing to the application server to port 8080 using TCP"
  }

}

# Create Network Security Group and rule - For private subnet
resource "azurerm_network_security_group" "nsg_private" {
  name                    = "NSG_Private"
  location                = var.location
  resource_group_name     = var.resourse_group_name

    security_rule {
    direction                   = "Inbound"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range      = "22"
    protocol                    = "Tcp"
    access                      = "Allow"
    priority                    = 100
    name                        = "Inbound_AllowSSH"
    description                 = "Accessing SSH inbound"
  }

    # TODO: Define source_address_prefix (the local address of vm-db) which is in nic_vm_db. At the moment the defenition is "*"
    security_rule {
    direction                   = "Inbound"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range      = "5432"
    protocol                    = "Tcp"
    access                      = "Allow"
    priority                    = 110
    name                        = "Inbound_AllowPostgre"
    description                 = "Allow VM-APP to communicate with postgreSQL"
  }

}

/*
##########################################
 Association - Subnets and Security groups 
 #########################################
*/

# association betweeen the Public subnet and the Public security group - Public
resource "azurerm_subnet_network_security_group_association" "association_nsg_public" {
  subnet_id                 = azurerm_subnet.subnet_public.id
  network_security_group_id = azurerm_network_security_group.nsg_public.id
}

# association betweeen the Private subnet and the Private security group - Private
resource "azurerm_subnet_network_security_group_association" "association_nsg_private" {
  subnet_id                 = azurerm_subnet.subnet_private.id
  network_security_group_id = azurerm_network_security_group.nsg_private.id
}
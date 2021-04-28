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


/*
##########################################
Load Balancer - Creation of a LoadBalancer - GateWay
#########################################
*/

###### "Load Balancer - Geteway"

# Create a "Load Balancer - Geteway" (Between the internet and the VM)
# and Add a Frontend IP configuration rule
resource "azurerm_lb" "lb_gw_resource" {
  name                    = var.load_balancer_gw_name
  resource_group_name     = var.resourse_group_name
  location                = var.location
  sku                     = "Standard"

  frontend_ip_configuration {
    name                 = "FrontEnd_config_lb_gw"
    public_ip_address_id = azurerm_public_ip.publicip_lb_gw_resource.id
  }
}

# Backend for the Load Balancer - Creating the BackEnd pool
resource "azurerm_lb_backend_address_pool" "back_end_address_pool_lb_gw" {
  name                    = "BackEnd_Pool"
  # resource_group_name     = var.resourse_group_name
  loadbalancer_id         = azurerm_lb.lb_gw_resource.id
}

# Create a Health Probe for the Load Balancer
resource "azurerm_lb_probe" "lb_HealthProbe_TCP_8080" {
  name                    = "HP_TCP_8080"
  resource_group_name     = var.resourse_group_name
  loadbalancer_id         = azurerm_lb.lb_gw_resource.id
  protocol                = "TCP"
  port                    = 8080
}

# Create a Load balancing Rule
resource "azurerm_lb_rule" "lb_gw_rule_allow_TCP_8080" {
  name                           = "Allow_TCP_8080"
  resource_group_name            = var.resourse_group_name
  loadbalancer_id                = azurerm_lb.lb_gw_resource.id
  protocol                       = "TCP"
  frontend_port                  = 8080
  backend_port                   = 8080
  backend_address_pool_id        = azurerm_lb_backend_address_pool.back_end_address_pool_lb_gw.id
  probe_id                       = azurerm_lb_probe.lb_HealthProbe_TCP_8080.id
  frontend_ip_configuration_name = azurerm_lb.lb_gw_resource.frontend_ip_configuration[0].name
} 


# Create Inbound NAT rules for the LB
resource "azurerm_lb_nat_rule" "lb_gw_rule_allow_RDP" {
  name                           = "Allow_TCP_RDP"
  resource_group_name            = var.resourse_group_name
  loadbalancer_id                = azurerm_lb.lb_gw_resource.id
  protocol                       = "TCP"
  frontend_port                  = 3389
  backend_port                   = 3389
  #frontend_ip_configuration_id   = azurerm_lb.lb_gw_resource.frontend_ip_configuration[0].id
  frontend_ip_configuration_name = azurerm_lb.lb_gw_resource.frontend_ip_configuration[0].name
}

/*
##########################################
 Public IP address For LB Gateway
 #########################################
*/

# Create public IP for LB-GW (Load Balancer)
resource "azurerm_public_ip" "publicip_lb_gw_resource" {
  name                    = "IP_LB"
  resource_group_name     = var.resourse_group_name
  location                = var.location
  allocation_method       = "Static"
  sku                     = "Standard"
}


/*
##########################################
Load Balancer - Creation of a LoadBalancer - Middleway
#########################################
*/

# Create a "Load Balancer - Geteway" (Between the internet and the VM)
# and Add a Frontend IP configuration rule
resource "azurerm_lb" "lb_middle_resource" {
  name                    = var.load_balancer_middle_name
  resource_group_name     = var.resourse_group_name
  location                = var.location
  sku                     = "Standard"
  
  frontend_ip_configuration {
    name                 = "FrontEnd_config_lb_middle"
    subnet_id            = azurerm_subnet.subnet_public.id
    # private_ip_address   = var.front_end_ip
    # public_ip_address_id = azurerm_public_ip.publicip_lb_resource.id
  }
}

# Backend for the Load Balancer - Creating the BackEnd pool
resource "azurerm_lb_backend_address_pool" "back_end_address_pool_lb_middle" {
  name                    = "BackEnd_Pool"
  # resource_group_name     = var.resourse_group_name
  loadbalancer_id         = azurerm_lb.lb_middle_resource.id
}

# Create a Health Probe for the Load Balancer
resource "azurerm_lb_probe" "lb_HealthProbe_TCP_5432" {
  name                    = "HP_TCP_5432"
  resource_group_name     = var.resourse_group_name
  loadbalancer_id         = azurerm_lb.lb_middle_resource.id
  protocol                = "TCP"
  port                    = 5432
}

# Create Inbound NAT rules for the LB
resource "azurerm_lb_nat_rule" "lb_mid_rule_allow_PostGre" {
  name                           = "Allow_TCP_PostGre"
  resource_group_name            = var.resourse_group_name
  loadbalancer_id                = azurerm_lb.lb_middle_resource.id
  protocol                       = "TCP"
  frontend_port                  = 5432
  backend_port                   = 5432
  #frontend_ip_configuration_id   = azurerm_lb.lb_middle_resource.frontend_ip_configuration[0].id
  frontend_ip_configuration_name = azurerm_lb.lb_middle_resource.frontend_ip_configuration[0].name
}
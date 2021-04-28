/*
#######################################
General Parameters
######################################
*/

variable "resourse_group_name" {
    type = string
}

variable "location" {
    type = string
}

/*
#######################################
Vnet and Subnet parameters 
 ######################################
*/

variable "vnet_address_space" {
    type = list
    default = ["10.0.0.0/27"] 
}

variable "subnet_prefix_public" {
    type = list
    default = ["10.0.0.0/28"]
}

variable "subnet_prefix_private" {
    type = list
    default = ["10.0.0.16/28"]
}

/*
#######################################
 Load Balancer parameters 
 ######################################
*/
variable "load_balancer_gw_name" {
  type = string
}

variable "load_balancer_middle_name" {
  type = string
}
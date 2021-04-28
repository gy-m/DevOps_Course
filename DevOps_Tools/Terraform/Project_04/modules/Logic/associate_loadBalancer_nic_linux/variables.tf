/*
#######################################
General Variables 
######################################
*/
variable "location" {
    type = string
}

variable "resourse_group_name" {
    type = string
}

variable "nic_id" {
    type = string
}

variable "nic_ip_config_name" {
    type = string
}

/*
#######################################
 Load Balancer parameters 
 ######################################
*/


variable "frontEnd_address_public_id" {
    type = string  
}


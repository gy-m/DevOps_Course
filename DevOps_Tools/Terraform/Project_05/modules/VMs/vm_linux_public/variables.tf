/*
#######################################
VM Parameters
######################################
*/
variable "vm_name" {
    type = list(string)
}
/*
variable "vm_name" {
    type = string
    default = "VM_Name_Default"
}
*/
variable "resourse_group_name" {
    type = string
    default = "RG_Name_Default"
}

variable "vm_zones" {
    type = string
}

# user name
variable "admin_username" {
    type = string
    description = "Administrator user name for virtual machine"
}

# password
variable "admin_password" {
    type = string
    description = "Password must meet Azure complexity requirements"
}

/*
#######################################
NIC Parameters
######################################
*/

# variable "nic_vm_name" {
#   type = string
# }

variable "subnet_public_id" {
    type = string
}


/*
#######################################
Additional Parameters
######################################
*/

variable "location" {
    type = string
}
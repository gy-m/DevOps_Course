/*
#######################################
General Variables 
######################################
*/
variable "location" {
    type = string
    # default = "Germany West Central"
    default = "France Central"  
}

/*
#######################################
VM Variables 
######################################
*/

variable "vm_name_windows_public" {
    type = list(string)
    default = ["VM-JenkMaster"]
}

variable "vm_name_linux_public" {
    type = list(string)
    default = ["VM-JenkBuild", "VM-JenkDeploy"]
}

variable "vm_name_linux_private" {
    type = list(string)
    default = ["VM-DB"]
}

/*
#######################################
Credentials Variables (declarations)
######################################
*/

# user name for VM-APP
variable "admin_username_VM_APP" {
    type = string
    description = "Administrator user name for virtual machine"
}

# password for VM-APP
variable "admin_password_VM_APP" {
    type = string
    description = "Password must meet Azure complexity requirements"
}

# user name for VM-DB
variable "admin_username_VM_DB" {
    type = string
    description = "Administrator user name for virtual machine"
}

# password for VM-DB
variable "admin_password_VM_DB" {
    type = string
    description = "Password must meet Azure complexity requirements"
}
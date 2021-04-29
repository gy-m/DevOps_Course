/*
#######################################
General Variables 
######################################
*/
variable "location" {
    type = string
    default = "France Central"
    # default = "Germany West Central"
  
}

/*
#######################################
VM Variables 
######################################
*/

variable "vm_name_windows" {
    type = list(string)
    default = ["VM-APP-01", "VM-APP-02", "VM-APP-03"]
}

variable "vm_name_linux" {
    type = list(string)
    default = ["VM-DB-01", "VM-DB-02", "VM-DB-03"]
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
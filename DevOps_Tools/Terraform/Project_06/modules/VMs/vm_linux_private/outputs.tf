############################## Outputs ####################################

# output "nic_id" {
#     value = azurerm_network_interface.nic_resource.id
# }

# If we used for to create multiple machines, we can not transfer an id of nic_resource element
# because this time nic_resource is a list so we must to pass all the list with all the elements
# later, the we will extract the id from the elements of this array
output "nic_resource" {
    value = azurerm_network_interface.nic_resource
}
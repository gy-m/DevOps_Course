############################## Outputs ####################################

output "subnet_public_id" {
    value = azurerm_subnet.subnet_public.id
}

output "subnet_private_id" {
    value = azurerm_subnet.subnet_private.id
}
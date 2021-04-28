############################## Outputs ####################################

output "subnet_public_id" {
    value = azurerm_subnet.subnet_public.id
}

output "subnet_private_id" {
    value = azurerm_subnet.subnet_private.id
}

output "back_end_address_pool_lb_gw_id" {
    value = azurerm_lb_backend_address_pool.back_end_address_pool_lb_gw.id
}

output "back_end_address_pool_lb_middle_id" {
    value = azurerm_lb_backend_address_pool.back_end_address_pool_lb_middle.id
}
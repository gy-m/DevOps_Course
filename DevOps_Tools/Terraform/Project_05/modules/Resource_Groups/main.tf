########################### Resource Groups #################################

# resource block - defines: "type" (component) and a "name" (id)
resource "azurerm_resource_group" "rg" {
  name     = var.resourse_group_name
  location = var.resourse_group_location
  # location = "Germany West Central"
}
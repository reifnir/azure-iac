output "dns_zone_reifnir_com_id" {
  value = azurerm_dns_zone.reifnir_com.id
}

output "container_registry_id" {
  value = azurerm_container_registry.reifnir.id
}

output "dns_zone_decomposingsoftware_com_id" {
  value = azurerm_dns_zone.decomposingsoftware_com.id
}

output "dns_zone_andreasen_dev_id" {
  value = azurerm_dns_zone.andreasen_dev.id
}

output "dns_zone_andreasen_dev_ns" {
  value = azurerm_dns_zone.andreasen_dev.name_servers
}

# output "debugging" {
#   value = azurerm_dns_zone.reifnir_com
# }

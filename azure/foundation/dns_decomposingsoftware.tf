resource "azurerm_dns_zone" "decomposingsoftware_com" {
  name                = "decomposingsoftware.com"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_DECOMPOSINGSOFTWARE_COM" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_DECOMPOSINGSOFTWARE_COM"
  variable_type = "env_var"
  value         = azurerm_dns_zone.decomposingsoftware_com.id
  protected     = false
  masked        = false
}

resource "azurerm_dns_txt_record" "protonmail_decomposingsoftware_com_verification" {
  name                = "@"
  zone_name           = azurerm_dns_zone.decomposingsoftware_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "protonmail-verification=e0ca8dd243aa0da17e57aa3d2737bdef4e1a34ef"
  }

  tags = local.tags
}

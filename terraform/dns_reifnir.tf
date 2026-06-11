resource "azurerm_resource_group" "dns" {
  name     = "rg-dns-zones"
  location = var.location
  tags     = local.tags
}

resource "azurerm_dns_zone" "reifnir_com" {
  name                = "reifnir.com"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "azurerm_dns_mx_record" "protonmail_reifnir_com" {
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 60

  record {
    preference = 10
    exchange   = "mail.protonmail.ch"
  }

  record {
    preference = 20
    exchange   = "mailsec.protonmail.ch"
  }

  tags = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_REIFNIR_COM" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_REIFNIR_COM"
  variable_type = "env_var"
  value         = azurerm_dns_zone.reifnir_com.id
  protected     = false
  masked        = false
  hidden        = false
}

resource "azurerm_dns_txt_record" "protonmail_reifnir_com_verification" {
  name                = "@"
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "protonmail-verification=d633505c520ac96355a35c40914d4a87736e598d"
  }

  record {
    value = "v=spf1 include:_spf.protonmail.ch mx ~all"
  }

  tags = local.tags
}

resource "azurerm_dns_cname_record" "protonmail_reifnir_com_dkim_1" {
  name                = "protonmail._domainkey"
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail.domainkey.dqhhubi4etmpyzqdpvtwbjuqg3n56vyu4g3u6thtwnvfuguca3ooa.domains.proton.ch."
}

resource "azurerm_dns_cname_record" "protonmail_reifnir_com_dkim_2" {
  name                = "protonmail2._domainkey"
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail2.domainkey.dqhhubi4etmpyzqdpvtwbjuqg3n56vyu4g3u6thtwnvfuguca3ooa.domains.proton.ch."
}

resource "azurerm_dns_cname_record" "protonmail_reifnir_com_dkim_3" {
  name                = "protonmail3._domainkey"
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail3.domainkey.dqhhubi4etmpyzqdpvtwbjuqg3n56vyu4g3u6thtwnvfuguca3ooa.domains.proton.ch."
}

resource "azurerm_dns_txt_record" "protonmail_reifnir_com_dmarc" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "v=DMARC1; p=none"
  }

  tags = local.tags
}

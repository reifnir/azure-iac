resource "azurerm_dns_zone" "andreasen_dev" {
  name                = "andreasen.dev"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_ANDREASEN_DEV" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_ANDREASEN_DEV"
  variable_type = "env_var"
  value         = azurerm_dns_zone.andreasen_dev.id
  protected     = false
  masked        = false
}

resource "azurerm_dns_txt_record" "protonmail_andreasen_dev_verification" {
  name                = "@"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "protonmail-verification=3739ed01bdfe1fcdb31e46a542c893a7a101a7dc"
  }

  record {
    value = "v=spf1 include:_spf.protonmail.ch mx ~all"
  }

  tags = local.tags
}

resource "azurerm_dns_mx_record" "protonmail" {
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

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

resource "azurerm_dns_txt_record" "protonmail_dmarc" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "v=DMARC1; p=none"
  }

  tags = local.tags
}

resource "azurerm_dns_cname_record" "protonmail_dkim_1" {
  name                = "protonmail._domainkey"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail.domainkey.dfqlnqbmvrnfruaqciwla76ef2lkmpnhft2inoj5e6vzrskmb5jia.domains.proton.ch."
}

resource "azurerm_dns_cname_record" "protonmail_dkim_2" {
  name                = "protonmail2._domainkey"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail2.domainkey.dfqlnqbmvrnfruaqciwla76ef2lkmpnhft2inoj5e6vzrskmb5jia.domains.proton.ch."
}

resource "azurerm_dns_cname_record" "protonmail_dkim_3" {
  name                = "protonmail3._domainkey"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "protonmail3.domainkey.dfqlnqbmvrnfruaqciwla76ef2lkmpnhft2inoj5e6vzrskmb5jia.domains.proton.ch."
}


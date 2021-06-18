locals {
  app_gateway_name               = "ag-${var.name}"
  backend_address_pool_name      = "${local.app_gateway_name}-beap"
  frontend_port_name             = "${local.app_gateway_name}-feport"
  frontend_ip_configuration_name = "${local.app_gateway_name}-feip"
  http_setting_name              = "${local.app_gateway_name}-be-htst"
  listener_name                  = "${local.app_gateway_name}-httplstn"
  request_routing_rule_name      = "${local.app_gateway_name}-rqrt"
  # Yes, the Standard App Gateway SKU requires a Basic PIP SKU
  public_ip_sku               = var.app_gateway_tier == "Standard" ? "Basic" : "Standard"
  public_ip_allocation_method = var.app_gateway_tier == "Standard" ? "Dynamic" : "Static"

  #networkContributorRole         = "[concat('/subscriptions/', subscription().subscriptionId, '/providers/Microsoft.Authorization/roleDefinitions/', '4d97b98b-1d4f-4787-a291-c67834d212e7')]"
}

# Public IP
resource "azurerm_public_ip" "kube" {
  name                = "default_pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = local.public_ip_allocation_method
  sku                 = local.public_ip_sku

  tags = var.tags
}

resource "azurerm_application_gateway" "network" {
  name                = local.app_gateway_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  sku {
    name     = var.app_gateway_sku
    tier     = var.app_gateway_tier
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.app_gateway_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.kube.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  tags = var.tags

  # https://stackoverflow.com/questions/63691139/terraform-removes-configurations-resources-created-by-the-application-gateway-in
  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      redirect_configuration,
      request_routing_rule,
      ssl_certificate,
      tags,
      url_path_map,
    ]
  }
}

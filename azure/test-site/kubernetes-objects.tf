resource "kubernetes_pod" "test_reifnir_com" {
  metadata {
    name = "aspnetapp"
    labels = {
      app = "aspnetapp"
    }
  }

  spec {
    container {
      image = "mcr.microsoft.com/dotnet/core/samples:aspnetapp"
      name  = "aspnetapp-image"

      port {
        container_port = 80
        protocol       = "TCP"
      }
    }
  }
}

resource "kubernetes_service" "test_reifnir_com" {
  metadata {
    name = "aspnetapp"
  }
  spec {
    selector = {
      app = "aspnetapp"
    }
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress" "test_reifnir_com" {
  metadata {
    name = "aspnetapp"
    annotations = {
      "kubernetes.io/ingress.class" : "azure/application-gateway"
      "appgw.ingress.kubernetes.io/backend-hostname" : "iac-test-site.reifnir.com"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"

          backend {
            service_name = "aspnetapp"
            service_port = 80
          }
        }
      }
    }
  }
}

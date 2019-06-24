resource "kubernetes_pod" "mongo" {
  metadata {
    name = "mongo"
  }
  spec {
    container {
      image = "mongo:4.1-bionic"
      name = "mongo"
      port {
        container_port = 27017
        host_port = 27017
      }
    }
    container {
      image = "mongo-express:0.49"
      name = "mongo-express"
      port {
        container_port = 8081
        host_port = 8081
      }
    }
  }
}

resource "kubernetes_service" "mongo" {
  metadata {
    name = "mongo-service"
  }
  spec {
    selector = {
      name = "mongo-express"
    }
    port {
      port = 8081
      target_port = 8081
    }

    type = "LoadBalancer"
  }
  depends_on = [kubernetes_pod.mongo]
}

terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "test" {
  source = "../../../../regional"

  api_key                 = "mock"
  app_key                 = "mock"
  environment             = var.environment
  kubernetes_cluster_name = "mock"
  region                  = var.region
}

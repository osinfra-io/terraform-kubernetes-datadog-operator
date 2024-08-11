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

  cluster_prefix  = "mock"
  datadog_api_key = "mock"
  datadog_app_key = "mock"
  environment     = var.environment
  region          = var.region
}

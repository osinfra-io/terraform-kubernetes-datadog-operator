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

  datadog_api_key = "mock"
  datadog_app_key = "mock"
}

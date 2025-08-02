# Required Providers
# https://opentofu.org/docs/language/providers/requirements

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

  api_key        = "mock"
  app_key        = "mock"
  cluster_prefix = "mock"
}

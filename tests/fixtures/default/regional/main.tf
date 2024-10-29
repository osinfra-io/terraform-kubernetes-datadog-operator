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

  api_key                     = "mock"
  app_key                     = "mock"
  cluster_prefix              = "mock-cluster-prefix"
  helpers_cost_center         = var.helpers_cost_center
  helpers_data_classification = var.helpers_data_classification
  helpers_email               = var.helpers_email
  helpers_repository          = var.helpers_repository
  helpers_team                = var.helpers_team
}

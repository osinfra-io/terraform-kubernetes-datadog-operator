terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "test_manifests" {
  source = "../../../../../regional/manifests"

  api_key                     = "mock"
  app_key                     = "mock"
  enable_apm_instrumentation  = true
  cluster_prefix              = "mock"
  helpers_cost_center         = var.helpers_cost_center
  helpers_data_classification = var.helpers_data_classification
  helpers_email               = var.helpers_email
  helpers_repository          = var.helpers_repository
  helpers_team                = var.helpers_team

  node_agent_tolerations = [
    {
      key      = "dedicated"
      operator = "Equal"
      value    = "mock"
      effect   = "NoExecute"
    }
  ]

  registry = "mock-docker.pkg.dev/mock-project/mock-virtual"
  team     = "mock-team"
}

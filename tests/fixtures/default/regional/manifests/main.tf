terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "test_manifests" {
  source = "../../../../../regional/manifests"

  cluster_prefix             = "mock-cluster"
  datadog_api_key            = "mock"
  datadog_app_key            = "mock"
  enable_apm_instrumentation = true
  environment                = var.environment

  node_agent_tolerations = [
    {
      key      = "dedicated"
      operator = "Equal"
      value    = "mock"
      effect   = "NoExecute"
    }
  ]

  region   = var.region
  registry = "mock-docker.pkg.dev/mock-project/mock-virtual"
  team     = "mock-team"
}

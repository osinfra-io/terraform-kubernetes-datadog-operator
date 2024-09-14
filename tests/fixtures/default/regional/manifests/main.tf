terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "test_manifests" {
  source = "../../../../../regional/manifests"

  api_key                    = "mock"
  app_key                    = "mock"
  enable_apm_instrumentation = true
  environment                = var.environment
  kubernetes_cluster_name    = "mock"

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

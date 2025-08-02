# Required Providers
# https://opentofu.org/docs/language/providers/requirements

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
  cluster_prefix             = "mock"

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

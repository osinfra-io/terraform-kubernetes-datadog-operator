# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  cluster_name = "${var.cluster_prefix}-${local.region}-${local.zone}-${local.env}"

  env = lookup(local.env_map, local.environment, "none")

  env_map = {
    "non-production" = "nonprod"
    "production"     = "prod"
    "sandbox"        = "sb"
  }

  environment = (
    terraform.workspace == "default" ?
    "mock-environment" :
    (regex(".*-(?P<environment>[^-]+)$", terraform.workspace)["environment"])
  )

  helm_sensitive_values = {
    "apiKey" = var.api_key
    "appKey" = var.app_key
  }

  helm_values = {
    "clusterName"                              = local.cluster_name
    "datadogMonitor.enabled"                   = true
    "podLabels.tags\\.datadoghq\\.com/env"     = local.environment
    "podLabels.tags\\.datadoghq\\.com/version" = var.operator_version
    "resources.limits.cpu"                     = var.limits_cpu
    "resources.limits.memory"                  = var.limits_memory
    "resources.requests.cpu"                   = var.requests_cpu
    "resources.requests.memory"                = var.requests_memory
    "watchNamespaces"                          = join(",", var.watch_namespaces)
  }

  region = (
    terraform.workspace == "default" ?
    "mock-region" :
    (regex("^(?P<region>[^-]+-[^-]+)", terraform.workspace)["region"])
  )

  zone = (
    terraform.workspace == "default" ?
    "mock-zone" :
    (regex("^(?P<region>[^-]+-[^-]+)-(?P<zone>[^-]+)", terraform.workspace)["zone"])
  )
}

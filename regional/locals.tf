# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  cluster_name = module.helpers.zone != null ? "${var.cluster_prefix}-${module.helpers.region}-${module.helpers.zone}-${module.helpers.env}" : "${var.cluster_prefix}-${module.helpers.region}-${module.helpers.env}"

  helm_sensitive_values = {
    "apiKey" = var.api_key
    "appKey" = var.app_key
  }

  helm_values = {
    "clusterName"                              = local.cluster_name
    "datadogMonitor.enabled"                   = true
    "podLabels.tags\\.datadoghq\\.com/env"     = module.helpers.environment
    "podLabels.tags\\.datadoghq\\.com/version" = var.operator_version
    "resources.limits.cpu"                     = var.limits_cpu
    "resources.limits.memory"                  = var.limits_memory
    "resources.requests.cpu"                   = var.requests_cpu
    "resources.requests.memory"                = var.requests_memory
    "watchNamespaces"                          = join(",", var.watch_namespaces)
  }
}

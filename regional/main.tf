# Terraform Core Helpers Module (osinfra.io)
# https://github.com/osinfra-io/terraform-core-helpers

module "helpers" {
  source = "github.com/osinfra-io/terraform-core-helpers?ref=v0.1.0"

  cost_center         = var.helpers_cost_center
  data_classification = var.helpers_data_classification
  email               = var.helpers_email
  repository          = var.helpers_repository
  team                = var.helpers_team
}

# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "datadog_operator" {
  chart      = "datadog-operator"
  name       = "datadog-operator"
  namespace  = "datadog"
  repository = "https://helm.datadoghq.com"

  dynamic "set" {
    for_each = local.helm_values
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = local.helm_sensitive_values
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  timeout = 900

  values = [
    file("${path.module}/helm/datadog-operator.yml")
  ]

  version = var.operator_version
}

# Kubernetes Secret Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1

resource "kubernetes_secret_v1" "datadog_operator_secret" {
  metadata {
    name      = "datadog-operator-secret"
    namespace = "datadog"
  }

  data = {
    "api-key" = var.api_key
    "app-key" = var.app_key
  }
}

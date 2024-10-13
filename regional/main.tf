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

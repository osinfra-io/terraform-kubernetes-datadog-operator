# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "datadog_operator" {
  chart      = "datadog-operator"
  name       = "datadog-operator"
  namespace  = kubernetes_namespace_v1.datadog.metadata[0].name
  repository = "https://helm.datadoghq.com"

  set {
    name  = "clusterName"
    value = local.cluster_name
  }

  set {
    name  = "datadogMonitor.enabled"
    value = true
  }

  set {
    name  = "watchNamespaces"
    value = join(",", var.watch_namespaces)
  }

  set_sensitive {
    name  = "apiKey"
    value = var.datadog_api_key
  }

  set_sensitive {
    name  = "appKey"
    value = var.datadog_app_key
  }

  timeout = 900

  values = [
    file("${path.module}/helm/datadog-operator.yml")
  ]

  version = "1.8.6"
}

# Kubernetes Namespace Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1

resource "kubernetes_namespace_v1" "datadog" {
  metadata {
    name = "datadog"
  }
}

# Kubernetes Secret Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1

resource "kubernetes_secret_v1" "datadog_operator_secret" {
  metadata {
    name      = "datadog-operator-secret"
    namespace = kubernetes_namespace_v1.datadog.metadata[0].name
  }

  data = {
    "api-key" = var.datadog_api_key
    "app-key" = var.datadog_app_key
  }
}

# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  env                     = var.environment == "sandbox" ? "sb" : var.environment == "non-production" ? "non-prod" : var.environment == "production" ? "prod" : "none"
  kubernetes_cluster_name = "${var.cluster_prefix}-${var.region}-${local.env}"
  kubernetes_monitor_templates = {
    "crash-loop-backoff" = {
      message = <<-EOF
      Pod {{pod_name.name}} is in CrashLoopBackOff on {{kube_namespace.name}} on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Pods in CrashLoopBackOff on namespace {{kube_namespace.name}} on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "max(last_10m):default_zero(max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff, kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name}) >= 1"
      thresholds_critical = 1
      thresholds_warning  = null
      type                = "query alert"
    }

    "failing-deployment-replicas" = {
      message = <<-EOF
      More than one Deployments Replica pods are down in Deployment {{kube_namespace.name}}/{{kube_deployment.name}} on {{kube_cluster_name.name}} cluster."\
      EOF

      name                = "[Kubernetes] Deployments Replica Pods are down on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,kube_deployment} - avg:kubernetes_state.deployment.replicas_available{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,kube_deployment} >= 2"
      thresholds_critical = 2
      thresholds_warning  = null
      type                = "query alert"
    }

    "failing-pods" = {
      message = <<-EOF
      More than ten pods are failing in ({{kube_cluster_name.name}} cluster).
      EOF

      name                = "[Kubernetes] Failed Pods in Namespaces on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "change(avg(last_5m),last_5m):default_zero(sum:kubernetes_state.pod.status_phase{pod_phase:failed, kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name}) > 10"
      thresholds_critical = 10
      thresholds_warning  = 5
      type                = "query alert"
    }

    "failing-statefulset-replicas" = {
      message = <<-EOF
      More than one Statefulset Replica pods are down in Statefulset {{kube_namespace.name}}/{{kube_stateful_set.name}} on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Statefulset Replicas are down on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,kube_stateful_set} - sum:kubernetes_state.statefulset.replicas_ready{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,kube_stateful_set} >= 2"
      thresholds_critical = 2
      thresholds_warning  = null
      type                = "query alert"
    }

    "high-cpu-usage" = {
      message = <<-EOF
      CPU usage is over 90% on {{kube_namespace.name}}/{{kube_pod_name.name}} on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Pod CPU usage is high on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "avg(last_5m):(avg:kubernetes.cpu.usage.total{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name} / 10000000) / avg:kubernetes.cpu.limits{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name} > 90"
      thresholds_critical = 90
      thresholds_warning  = 80
      type                = "metric alert"
    }

    "high-memory-usage" = {
      message = <<-EOF
      Memory usage is over 90% on {{kube_namespace.name}}/{{kube_pod_name.name}} on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Pod Memory usage is high on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "avg(last_5m):avg:kubernetes.memory.usage{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name} / avg:kubernetes.memory.limits{kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name} * 100 > 90"
      thresholds_critical = 90
      thresholds_warning  = 80
      type                = "metric alert"
    }

    "image-pull-backoff" = {
      message = <<-EOF
      Pod {{pod_name.name}} is in ImagePullBackOff on {{kube_namespace.name}} on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Pods in ImagePullBackOff on namespace {{kube_namespace.name}} on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "max(last_10m):default_zero(max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff, kube_cluster_name:${local.kubernetes_cluster_name}} by {kube_namespace,pod_name}) >= 1"
      thresholds_critical = 1
      thresholds_warning  = null
      type                = "query alert"
    }

    "restarting-pods" = {
      message = <<-EOF
      Pod {{pod_name.name}} restarted multiple times in the last five minutes on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Pods Restarting on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "change(max(last_5m),last_5m):sum:kubernetes.containers.restarts{kube_cluster_name:${local.kubernetes_cluster_name}} by {pod_name} > 5"
      thresholds_critical = 5
      thresholds_warning  = 3
      type                = "query alert"
    }

    "unschedulable-node" = {
      message = <<-EOF
      More than 20% of nodes are unschedulable on {{kube_cluster_name.name}} cluster.
      EOF

      name                = "[Kubernetes] Unschedulable Nodes on ${local.kubernetes_cluster_name}"
      priority            = 3
      query               = "max(last_15m):default_zero(sum:kubernetes_state.node.status{status:schedulable}, kube_cluster_name:${local.kubernetes_cluster_name}} * 100 / sum:kubernetes_state.node.status{*} by kube_cluster_name:${local.kubernetes_cluster_name}} < 80"
      thresholds_critical = 80
      thresholds_warning  = 90
      type                = "query alert"
    }
  }

  node_agent_env_vars = [
    {
      name  = "DD_CONTAINER_EXCLUDE"
      value = "kube_namespace:^gke-managed-cim$ kube_namespace:^gke-managed-system kube_namespace:^gke-mcs$ kube_namespace:^gmp-system$ kube_namespace:^kube-node-lease$ kube_namespace:^kube-public$ kube_namespace:^kube-system$ ${var.node_agent_env_dd_container_exclude}"
    },
    {
      name  = "DD_IGNORE_AUTOCONF"
      value = "cilium ${var.node_agent_env_dd_ignore_auto_conf}"
    }
  ]

  trace_agent_env_vars = [

    # Ignoring Unwanted Resources in APM
    # https://docs.datadoghq.com/tracing/guide/ignoring_apm_resources

    {
      name  = "DD_APM_FILTER_TAGS_REGEX_REJECT"
      value = "http.useragent:kube-probe/\\d+\\.\\d+ http.url:https?:\\/\\/[^\\/]+\\/favicon\\.ico ${var.trace_agent_env_dd_apm_filter_tags_regex_reject}"
    }
  ]

  tags = [
    "cluster:${local.kubernetes_cluster_name}",
    "env:${var.environment}",
    "generated:datadog-operator",
    "region:${var.region}",
    "team:${var.team}"
  ]
}

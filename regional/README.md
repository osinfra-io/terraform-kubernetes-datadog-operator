# Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 3.0.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.37.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helpers"></a> [helpers](#module\_helpers) | github.com/osinfra-io/terraform-core-helpers//child | v0.1.2 |

## Resources

| Name | Type |
|------|------|
| [helm_release.datadog_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret_v1.datadog_operator_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_namespace"></a> [agent\_namespace](#input\_agent\_namespace) | Namespace for the Datadog Agent | `string` | `"datadog"` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Datadog API key | `string` | n/a | yes |
| <a name="input_app_key"></a> [app\_key](#input\_app\_key) | Datadog APP key | `string` | n/a | yes |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name, region, and zone (if applicable) will be added to the end of the cluster name | `string` | n/a | yes |
| <a name="input_limits_cpu"></a> [limits\_cpu](#input\_limits\_cpu) | CPU limits for the Datadog Operator | `string` | `"200m"` | no |
| <a name="input_limits_memory"></a> [limits\_memory](#input\_limits\_memory) | Memory limits for the Datadog Operator | `string` | `"64Mi"` | no |
| <a name="input_operator_version"></a> [operator\_version](#input\_operator\_version) | The version of the Datadog Operator to install | `string` | `"2.10.0"` | no |
| <a name="input_requests_cpu"></a> [requests\_cpu](#input\_requests\_cpu) | CPU requests for the Datadog Operator | `string` | `"100m"` | no |
| <a name="input_requests_memory"></a> [requests\_memory](#input\_requests\_memory) | Memory requests for the Datadog Operator | `string` | `"32Mi"` | no |
| <a name="input_watch_namespaces"></a> [watch\_namespaces](#input\_watch\_namespaces) | Restricts the Operator to watch its managed resources on specific namespaces - set to [""] to watch all namespaces | `list(string)` | <pre>[<br/>  "datadog"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

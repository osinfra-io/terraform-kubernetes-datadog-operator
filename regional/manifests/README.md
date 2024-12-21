# Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.35.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helpers"></a> [helpers](#module\_helpers) | github.com/osinfra-io/terraform-core-helpers//child | v0.1.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.agent](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.kubernetes_monitor_templates](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_priority_class_v1.datadog](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/priority_class_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Datadog API key | `string` | n/a | yes |
| <a name="input_app_key"></a> [app\_key](#input\_app\_key) | Datadog APP key | `string` | n/a | yes |
| <a name="input_cluster_agent_env_vars"></a> [cluster\_agent\_env\_vars](#input\_cluster\_agent\_env\_vars) | Environment variables for the cluster agent | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cluster_agent_limits_cpu"></a> [cluster\_agent\_limits\_cpu](#input\_cluster\_agent\_limits\_cpu) | CPU limits for the Datadog cluster agent | `string` | `"200m"` | no |
| <a name="input_cluster_agent_limits_memory"></a> [cluster\_agent\_limits\_memory](#input\_cluster\_agent\_limits\_memory) | Memory limits for the Datadog cluster agent | `string` | `"256Mi"` | no |
| <a name="input_cluster_agent_requests_cpu"></a> [cluster\_agent\_requests\_cpu](#input\_cluster\_agent\_requests\_cpu) | CPU requests for the Datadog cluster agent | `string` | `"100m"` | no |
| <a name="input_cluster_agent_requests_memory"></a> [cluster\_agent\_requests\_memory](#input\_cluster\_agent\_requests\_memory) | Memory requests for the Datadog cluster agent | `string` | `"128Mi"` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name, region, and zone (if applicable) will be added to the end of the cluster name | `string` | n/a | yes |
| <a name="input_enable_apm"></a> [enable\_apm](#input\_enable\_apm) | Enable Application Performance Monitoring (APM)<br/>    Cost: $36.00 per host monthly | `bool` | `false` | no |
| <a name="input_enable_apm_instrumentation"></a> [enable\_apm\_instrumentation](#input\_enable\_apm\_instrumentation) | Enable Application Performance Monitoring (APM) Single-Step instrumentation | `bool` | `false` | no |
| <a name="input_enable_asm_iast"></a> [enable\_asm\_iast](#input\_enable\_asm\_iast) | Enable Interactive Application Security Testing (IAST) | `bool` | `false` | no |
| <a name="input_enable_asm_sca"></a> [enable\_asm\_sca](#input\_enable\_asm\_sca) | Enable Software Composition Analysis (SCA) | `bool` | `false` | no |
| <a name="input_enable_asm_threats"></a> [enable\_asm\_threats](#input\_enable\_asm\_threats) | Enable ASM App & API Protection<br/>    Cost: $36.00 per host monthly | `bool` | `false` | no |
| <a name="input_enable_container_collect_all"></a> [enable\_container\_collect\_all](#input\_enable\_container\_collect\_all) | Enable log collection for all containers | `bool` | `true` | no |
| <a name="input_enable_cspm"></a> [enable\_cspm](#input\_enable\_cspm) | Enable Cloud Security Posture Management (CSPM)<br/>    Cost: $12.00 per host monthly | `bool` | `false` | no |
| <a name="input_enable_cws"></a> [enable\_cws](#input\_enable\_cws) | Enable Cloud Workload Security (CWS)<br/>    Cost: $36.00 per host monthly | `bool` | `false` | no |
| <a name="input_enable_cws_network_detection"></a> [enable\_cws\_network\_detection](#input\_enable\_cws\_network\_detection) | Enable Cloud Workload Security (CWS) network detections | `bool` | `false` | no |
| <a name="input_enable_external_metrics_server"></a> [enable\_external\_metrics\_server](#input\_enable\_external\_metrics\_server) | Enable the External Metrics Server | `bool` | `true` | no |
| <a name="input_enable_jmx"></a> [enable\_jmx](#input\_enable\_jmx) | Whether the Agent image should support JMX | `bool` | `false` | no |
| <a name="input_enable_log_collection"></a> [enable\_log\_collection](#input\_enable\_log\_collection) | Enable log collection | `bool` | `true` | no |
| <a name="input_enable_npm"></a> [enable\_npm](#input\_enable\_npm) | Enable Network Performance Monitoring (NPM) | `bool` | `true` | no |
| <a name="input_enable_sbom"></a> [enable\_sbom](#input\_enable\_sbom) | Enable Software Bill of Materials (SBOM) | `bool` | `true` | no |
| <a name="input_enable_usm"></a> [enable\_usm](#input\_enable\_usm) | Enable Universal Service Monitoring (USM) | `bool` | `true` | no |
| <a name="input_node_agent_env_dd_container_exclude"></a> [node\_agent\_env\_dd\_container\_exclude](#input\_node\_agent\_env\_dd\_container\_exclude) | Environment variable for the Datadog node agent to exclude containers | `string` | `""` | no |
| <a name="input_node_agent_env_dd_ignore_auto_conf"></a> [node\_agent\_env\_dd\_ignore\_auto\_conf](#input\_node\_agent\_env\_dd\_ignore\_auto\_conf) | Environment variable for the Datadog node agent to ignore auto configuration | `string` | `""` | no |
| <a name="input_node_agent_image"></a> [node\_agent\_image](#input\_node\_agent\_image) | Image for the Datadog node agent, relative to datadog | `string` | `"agent"` | no |
| <a name="input_node_agent_limits_cpu"></a> [node\_agent\_limits\_cpu](#input\_node\_agent\_limits\_cpu) | CPU limits for the Datadog Node Agent | `string` | `"200m"` | no |
| <a name="input_node_agent_limits_memory"></a> [node\_agent\_limits\_memory](#input\_node\_agent\_limits\_memory) | Memory limits for the Datadog Node Agent | `string` | `"256Mi"` | no |
| <a name="input_node_agent_log_level"></a> [node\_agent\_log\_level](#input\_node\_agent\_log\_level) | Node Agent log level | `string` | `"info"` | no |
| <a name="input_node_agent_requests_cpu"></a> [node\_agent\_requests\_cpu](#input\_node\_agent\_requests\_cpu) | CPU requests for the Datadog Node Agent | `string` | `"100m"` | no |
| <a name="input_node_agent_requests_memory"></a> [node\_agent\_requests\_memory](#input\_node\_agent\_requests\_memory) | Memory requests for the Datadog Node Agent | `string` | `"128Mi"` | no |
| <a name="input_node_agent_tag"></a> [node\_agent\_tag](#input\_node\_agent\_tag) | Tag for the Datadog node agent image | `string` | `"7.60.1"` | no |
| <a name="input_node_agent_tolerations"></a> [node\_agent\_tolerations](#input\_node\_agent\_tolerations) | Tolerations for the Datadog node agent | <pre>list(object({<br/>    key      = string<br/>    operator = string<br/>    value    = string<br/>    effect   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_registry"></a> [registry](#input\_registry) | Docker registry for the Datadog container images | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Team name to be used as a tag in Datadog | `string` | n/a | yes |
| <a name="input_trace_agent_env_dd_apm_filter_tags_regex_reject"></a> [trace\_agent\_env\_dd\_apm\_filter\_tags\_regex\_reject](#input\_trace\_agent\_env\_dd\_apm\_filter\_tags\_regex\_reject) | Environment variable values for the Datadog trace agent to regex reject APM tags | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

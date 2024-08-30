# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "agent" {
  manifest = {
    apiVersion = "datadoghq.com/v2alpha1"
    kind       = "DatadogAgent"
    metadata = {
      name      = "datadog"
      namespace = "datadog"
    }
    spec = {
      features = {
        apm = {
          enabled = var.enable_apm
          hostPortConfig = {
            enabled  = true
            hostPort = 8126
          }
          instrumentation = {
            enabled = var.enable_apm_instrumentation
          }
        }

        asm = {
          iast = {
            enabled = var.enable_asm_iast
          }
          sca = {
            enabled = var.enable_asm_sca
          }
          threats = {
            enabled = var.enable_asm_threats
          }
        }

        cspm = {
          enabled = var.enable_cspm
        }

        cws = {
          enabled = var.enable_cws
          network = {
            enabled = var.enable_cws_network_detection
          }
        }

        externalMetricsServer = {
          enabled = var.enable_external_metrics_server
        }

        logCollection = {
          containerCollectAll = var.enable_container_collect_all
          enabled             = var.enable_log_collection
        }

        npm = {
          enabled = var.enable_npm
        }

        sbom = {
          containerImage = {
            enabled = var.enable_sbom
          }
          enabled = var.enable_sbom
        }

        usm = {
          enabled = var.enable_usm
        }
      }

      global = {
        clusterName = "${var.cluster_prefix}-${var.region}-${var.environment}"
        credentials = {
          apiKey = var.datadog_api_key
          appKey = var.datadog_app_key
        }
        registry = "${var.registry}/datadog"
      }

      override = {
        clusterAgent = {
          env = var.cluster_agent_env_vars
        }

        nodeAgent = {
          containers = {
            agent = {
              logLevel = var.node_agent_log_level
              resources = {
                limits = {
                  cpu    = var.limits_cpu
                  memory = var.limits_memory
                }
                requests = {
                  cpu    = var.requests_cpu
                  memory = var.requests_memory
                }
              }
            }

            trace-agent = {
              env = concat(local.trace_agent_env_vars, var.trace_agent_env_vars)
            }
          }

          env = concat(local.node_agent_env_vars, var.node_agent_env_vars)
          extraConfd = {
            configDataMap = {
              "envoy.yaml"  = <<-EOF
              ad_identifiers:
                - proxyv2
              init_config:
              instances:
                - openmetrics_endpoint: http://%%host%%:15020/stats/prometheus
              logs:
                - source: envoy
              EOF
              "cilium.yaml" = <<-EOF
              ad_identifiers:
                - cilium
              init_config:
              instances:
                - agent_endpoint: http://%%host%%:9990/metrics
                  use_openmetrics: true
              EOF
            }
          }

          image = {
            jmxEnabled = var.enable_jmx
            name       = var.node_agent_image
            tag        = var.node_agent_tag
          }

          priorityClassName = kubernetes_priority_class_v1.datadog.metadata.0.name
          tolerations       = var.node_agent_tolerations
        }
      }
    }
  }

  field_manager {
    name            = "Terraform"
    force_conflicts = true
  }
}

resource "kubernetes_manifest" "kubernetes_monitor_templates" {
  for_each = local.kubernetes_monitor_templates

  manifest = {
    apiVersion = "datadoghq.com/v1alpha1"
    kind       = "DatadogMonitor"

    metadata = {
      name      = each.key
      namespace = "datadog"
    }

    spec = {
      query   = each.value.query
      type    = each.value.type
      name    = each.value.name
      message = each.value.message

      tags = local.tags

      options = {
        thresholds = {
          critical = each.value.thresholds_critical
          warning  = each.value.thresholds_warning
        }

        notifyNoData    = true
        noDataTimeframe = 5
      }

      priority = each.value.priority
    }
  }
}

# Kubernetes Priority Class Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/priority_class_v1

resource "kubernetes_priority_class_v1" "datadog" {
  description    = "Allow Datadog Agent Components to be scheduled with higher priority."
  global_default = false

  metadata {
    name = "datadog"
  }

  value = 1000000
}

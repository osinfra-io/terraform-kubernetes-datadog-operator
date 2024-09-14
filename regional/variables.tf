# Input Variables
# https://www.terraform.io/language/values/variables

variable "agent_namespace" {
  description = "Namespace for the Datadog Agent"
  type        = string
  default     = "datadog"
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name"
  type        = string
}

variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
  sensitive   = true
}

variable "datadog_operator_version" {
  description = "The version of the Datadog Operator to install"
  type        = string
  default     = "2.0.0"
}

variable "environment" {
  description = "The environment must be one of `sandbox`, `non-production`, `production`"
  type        = string
  default     = "sandbox"

  validation {
    condition     = contains(["mock-environment", "sandbox", "non-production", "production"], var.environment)
    error_message = "The environment must be one of `mock-environment` for tests or `sandbox`, `non-production`, or `production`."
  }
}

variable "limits_cpu" {
  description = "CPU limits for the Datadog Operator"
  type        = string
  default     = "200m"
}

variable "limits_memory" {
  description = "Memory limits for the Datadog Operator"
  type        = string
  default     = "64Mi"
}

variable "region" {
  description = "The region in which the resource belongs"
  type        = string
}

variable "requests_cpu" {
  description = "CPU requests for the Datadog Operator"
  type        = string
  default     = "100m"
}

variable "requests_memory" {
  description = "Memory requests for the Datadog Operator"
  type        = string
  default     = "32Mi"
}

variable "watch_namespaces" {
  description = "Restricts the Operator to watch its managed resources on specific namespaces - set to [\"\"] to watch all namespaces"
  type        = list(string)
  default     = ["datadog"]
}

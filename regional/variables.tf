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

variable "environment" {
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
}


variable "region" {
  description = "The region in which the resource belongs"
  type        = string
}

variable "watch_namespaces" {
  description = "Restricts the Operator to watch its managed resources on specific namespaces - set to [\"\"] to watch all namespaces"
  type        = list(string)
  default     = ["datadog"]
}

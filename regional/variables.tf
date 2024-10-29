# Input Variables
# https://www.terraform.io/language/values/variables

variable "agent_namespace" {
  description = "Namespace for the Datadog Agent"
  type        = string
  default     = "datadog"
}

variable "api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "app_key" {
  description = "Datadog APP key"
  type        = string
  sensitive   = true
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name, region, and zone (if applicable) will be added to the end of the cluster name"
  type        = string
}

variable "helpers_cost_center" {
  description = "The cost center the resources will be billed to, must start with 'x' followed by three or four digits"
  type        = string
}

variable "helpers_data_classification" {
  description = "The data classification of the resources can be public, internal, or confidential"
  type        = string
}

variable "helpers_email" {
  description = "The email address of the team responsible for the resources"
  type        = string
}

variable "helpers_repository" {
  description = "The repository name (should be in the format 'owner/repo' containing only lowercase alphanumeric characters or hyphens)"
  type        = string
}

variable "helpers_team" {
  description = "The team name (should contain only lowercase alphanumeric characters and hyphens)"
  type        = string
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

variable "operator_version" {
  description = "The version of the Datadog Operator to install"
  type        = string
  default     = "2.1.0"
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

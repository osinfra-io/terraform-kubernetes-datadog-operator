# Input Variables
# https://www.terraform.io/language/values/variables

variable "agent_namespace" {
  description = "Namespace for the Datadog Agent"
  type        = string
  default     = "datadog"
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

variable "watch_namespaces" {
  description = "Restricts the Operator to watch its managed resources on specific namespaces - set to [\"\"] to watch all namespaces"
  type        = list(string)
  default     = ["datadog"]
}

# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  cluster_name = "${var.cluster_prefix}-${var.region}-${local.env}"
  env          = var.environment == "sandbox" ? "sb" : var.environment == "non-production" ? "non-prod" : var.environment == "production" ? "prod" : "none"
}

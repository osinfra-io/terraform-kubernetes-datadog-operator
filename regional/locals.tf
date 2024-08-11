# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  cluster_name = "${var.cluster_prefix}-${var.region}-${var.environment}"
}

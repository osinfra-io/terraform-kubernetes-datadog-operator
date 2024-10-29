# Terraform Test
# https://developer.hashicorp.com/terraform/language/tests

mock_provider "kubernetes" {}
mock_provider "helm" {}

run "default_regional" {
  command = apply

  module {
    source = "./tests/fixtures/default/regional"
  }
}

run "default_manifests" {
  command = apply

  module {
    source = "./tests/fixtures/default/regional/manifests"
  }
}

variables {
  helpers_cost_center         = "mock-cost-center"
  helpers_data_classification = "mock-data-classification"
  helpers_email               = "mock-team@osinfra.io"
  helpers_repository          = "mock-owner/mock-repository"
  helpers_team                = "mock-team"
}

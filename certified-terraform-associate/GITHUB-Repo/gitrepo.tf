terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.10.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = var.github_generic_token
}

resource "github_repository" "test_repo" {
  name = "test_terraform_repo"
  description = "a sample repository created by terraform as IAC"
  visibility = "public"
}

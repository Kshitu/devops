terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "admin-user"
}

module "services" {
  source = "./services"
}

module "github-runner" {
  source = "./github-runner"
}
output "cloudfront_url" {
  value = module.services.cloudfront_url
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.29"
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

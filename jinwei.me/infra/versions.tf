terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.19.2"
    }
  }
}

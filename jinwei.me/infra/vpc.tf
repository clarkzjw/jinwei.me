locals {
  cidr_block    = "10.31.0.0/16"
  subnets       = cidrsubnets(local.cidr_block, 4, 4, 4, 4, 4, 4)
  subnet_groups = chunklist(local.subnets, 3)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name                 = local.name
  cidr                 = local.cidr_block
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = local.subnet_groups[0]
  public_subnets       = local.subnet_groups[1]
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  single_nat_gateway   = true
}



resource "aws_db_subnet_group" "jinwei-me" {
  name       = var.name
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = var.name
  }
}

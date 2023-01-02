provider "aws" {
  region = var.region
}

variable "name" {
  description = "Name of the service. It will be used to name EC2, and RDS instances."
  default     = "jinwei-me"
}

variable "region" {
  default     = "us-west-2"
  description = "AWS region"
}

# RDS
variable "rds_initial_db_name" {
  default = "wordpress"
}

variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "rds_storage" {
  default = 20
}

variable "rds_username" {
  default = "jinweime"
}

variable "rds_engine" {
  default = "mariadb"
}

variable "rds_engine_version" {
  default = "10.6"
}

variable "rds_parameter_group" {
  default = "mariadb10.6"
}

variable "rds_port" {
  default = 33060
}

# EC 2
variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "site_domain" {
  type    = string
  default = "jinwei.me"
}

variable "s3_cdn_name" {
  type    = string
  default = "static"
}

variable "s3_cloudfront_name" {
  type    = string
  default = "static.jinwei.me"
}

variable "cloudflare_account_id" {
  description = "The Cloudflare UUID for the Account the Zone lives in."
  type        = string
  sensitive   = true
}

variable "hetzner_username" {
  description = "Hetzner username"
  type        = string
  sensitive   = true
}

variable "hetzner_password" {
  description = "Hetzner password"
  type        = string
  sensitive   = true
}

variable "hetzner_storagebox" {
  description = "Hetzner storagebox url"
  type        = string
  sensitive   = true
}

variable "dockerhub_username" {
  description = "dockerhub username"
  type        = string
  sensitive   = true
}

variable "dockerhub_token" {
  description = "dockerhub token"
  type        = string
  sensitive   = true
}

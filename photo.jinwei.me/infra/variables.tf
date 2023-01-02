provider "aws" {
  region = var.region
}

variable "name" {
  description = "Name of the service. It will be used to name EC2, and RDS instances."
  default     = "jinwei-me"
}

variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

# RDS
variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "rds_storage" {
  default = 5
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
  default = "t3.micro"
}

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

variable "ttrss_db_name" {
  default = "ttrss"
}

variable "ttrss_db_user" {
  default = "ttrss"
}

variable "ttrss_site_url" {
  default = "feed.jinwei.me"
}

variable "rss_tgbot_token" {
  description = "Telegram bot token for rssbot"
  type        = string
  sensitive   = true
}

variable "tg_bot_version" {
  description = "Telegram rss bot version, from https://github.com/iovxw/rssbot/releases"
  default = "v2.0.0-alpha.11"
  type = string
}
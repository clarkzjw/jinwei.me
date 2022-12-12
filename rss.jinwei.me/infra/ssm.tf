resource "aws_ssm_parameter" "rss_site_url" {
  name  = "/${var.name}/rss/url"
  type  = "String"
  value = var.rss_site_url
}

resource "aws_ssm_parameter" "rss_db_name" {
  name  = "/${var.name}/mysql/rss_db_name"
  type  = "String"
  value = var.rss_db_name
}

resource "aws_ssm_parameter" "rss_db_user" {
  name  = "/${var.name}/mysql/rss_db_user"
  type  = "String"
  value = var.rss_db_user
}

resource "aws_ssm_parameter" "rss_db_password" {
  name  = "/${var.name}/mysql/rss_user_password"
  type  = "SecureString"
  value = random_password.rss_password.result
}

resource "aws_ssm_parameter" "rss_tgbot_token" {
  name  = "/${var.name}/tgbot/token"
  type  = "SecureString"
  value = var.rss_tgbot_token
}

resource "aws_ssm_parameter" "rss_tgbot_version" {
  name  = "/${var.name}/tgbot/version"
  type  = "String"
  value = var.tg_bot_version
}

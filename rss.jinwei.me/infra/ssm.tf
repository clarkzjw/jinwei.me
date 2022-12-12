resource "aws_ssm_parameter" "ttrss_site_url" {
  name  = "/${var.name}/ttrss/url"
  type  = "String"
  value = var.ttrss_site_url
}

resource "aws_ssm_parameter" "ttrss_db_name" {
  name  = "/${var.name}/mysql/ttrss_db_name"
  type  = "String"
  value = var.ttrss_db_name
}

resource "aws_ssm_parameter" "ttrss_db_user" {
  name  = "/${var.name}/mysql/ttrss_db_user"
  type  = "String"
  value = var.ttrss_db_user
}

resource "aws_ssm_parameter" "ttrss_db_password" {
  name  = "/${var.name}/mysql/ttrss_db_password"
  type  = "SecureString"
  value = random_password.ttrss_password.result
}

resource "aws_ssm_parameter" "ttrss_tgbot_token" {
  name  = "/${var.name}/tgbot/token"
  type  = "SecureString"
  value = var.rss_tgbot_token
}

resource "aws_ssm_parameter" "ttrss_tgbot_version" {
  name  = "/${var.name}/tgbot/version"
  type  = "String"
  value = var.tg_bot_version
}

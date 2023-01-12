resource "aws_ssm_parameter" "dockerhub_username" {
  name  = "/${local.name}/docker/username"
  type  = "SecureString"
  value = var.dockerhub_username
}

resource "aws_ssm_parameter" "dockerhub_token" {
  name  = "/${local.name}/docker/token"
  type  = "SecureString"
  value = var.dockerhub_token
}

resource "aws_secretsmanager_secret" "datadog_api_key" {
  name = "/${local.name}/datadog/api_key"
  type = "SecureString"
  value = var.datadog_api_key
}

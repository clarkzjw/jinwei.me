resource "aws_ssm_parameter" "hetzner_username" {
  name  = "/${local.name}/hetzner/username"
  type  = "SecureString"
  value = var.hetzner_username
}

resource "aws_ssm_parameter" "hetzner_password" {
  name  = "/${local.name}/hetzner/password"
  type  = "SecureString"
  value = var.hetzner_password
}

resource "aws_ssm_parameter" "hetzner_storagebox" {
  name  = "/${local.name}/hetzner/storagebox"
  type  = "SecureString"
  value = var.hetzner_storagebox
}


resource "aws_db_parameter_group" "jinwei-me" {
  name   = var.name
  family = var.rds_parameter_group
}

resource "aws_db_instance" "jinwei-me" {
  identifier             = var.name
  db_name                = var.rds_initial_db_name
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_storage
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  username               = var.rds_username
  password               = random_password.mysql_password.result
  port                   = var.rds_port
  db_subnet_group_name   = aws_db_subnet_group.jinwei-me.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.jinwei-me.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

resource "random_password" "mysql_password" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "wordpress_db_host" {
  name  = "/${var.name}/mysql/host"
  type  = "String"
  value = aws_db_instance.jinwei-me.address
}

resource "aws_ssm_parameter" "wordpress_db_port" {
  name  = "/${var.name}/mysql/port"
  type  = "String"
  value = aws_db_instance.jinwei-me.port
}

resource "aws_ssm_parameter" "wordpress_db_name" {
  name  = "/${local.name}/mysql/name"
  type  = "String"
  value = aws_db_instance.jinwei-me.db_name
}

resource "aws_ssm_parameter" "wordpress_db_user" {
  name  = "/${local.name}/mysql/username"
  type  = "String"
  value = aws_db_instance.jinwei-me.username
}

resource "aws_ssm_parameter" "wordpress_db_password" {
  name  = "/${local.name}/mysql/password"
  type  = "SecureString"
  value = random_password.mysql_password.result
}

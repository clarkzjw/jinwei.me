
resource "aws_db_parameter_group" "jinwei-me" {
  name   = var.name
  family = var.rds_parameter_group
}

resource "aws_db_instance" "jinwei-me" {
  identifier             = var.name
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

# EC 2
resource "aws_security_group" "backend" {
  name   = local.name
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "backend_ingress_ssh" {
  security_group_id = aws_security_group.backend.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "backend_egress_all" {
  security_group_id = aws_security_group.backend.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# RDS
resource "aws_security_group" "rds" {
  name   = "${local.name}-db"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "db_ingress_backend" {
  security_group_id        = aws_security_group.rds.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  source_security_group_id = aws_security_group.backend.id
}

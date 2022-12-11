output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.jinwei-me.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.jinwei-me.port
}

output "rds_username" {
  description = "RDS instance username"
  value       = aws_db_instance.jinwei-me.username
}

output "rds_password" {
  description = "RDS instance password"
  value       = random_password.mysql_password.result
  sensitive   = true
}

output "instance" {
  description = "The main EC2 instance."
  value = {
    arn        = aws_instance.jinwei_me.arn
    public_ip  = aws_eip.main.public_ip
    private_ip = aws_instance.jinwei_me.private_ip
  }
}

output "s3" {
  description = "S3 bucket for wordpress"
  value = {
    bucket_domain_name = aws_s3_bucket.main.bucket_domain_name
  }
}

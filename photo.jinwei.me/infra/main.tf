locals {
  name = var.name
}

data "aws_subnet" "ec2" {
  filter {
    name   = "availability-zone"
    values = [aws_db_instance.jinwei-me.availability_zone]
  }
  filter {
    name   = "subnet-id"
    values = module.vpc.public_subnets
  }
}

resource "aws_instance" "jinwei_me" {
  ami           = data.aws_ami.debian.id
  instance_type = var.ec2_instance_type

  subnet_id = data.aws_subnet.ec2.id
  key_name  = "framework"

  vpc_security_group_ids = [aws_security_group.backend.id]

  root_block_device {
    volume_type = "gp3"
    // how to resize partition and file system after resizing ebs volume
    // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html
    volume_size = "30"
    tags = {
      Name = "${local.name}-root"
    }
  }

  tags = {
    Name = local.name
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_eip" "jinwei-me" {
  instance = aws_instance.jinwei_me.id
}

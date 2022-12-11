data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
}

data "aws_availability_zones" "available" {}
data "cloudflare_ip_ranges" "cloudflare" {}

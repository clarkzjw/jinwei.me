provider "cloudflare" {}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "s3_bucket" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.s3_cdn_name
  value   = aws_s3_bucket.main.bucket_regional_domain_name
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

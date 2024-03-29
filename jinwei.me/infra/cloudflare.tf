provider "cloudflare" {}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "s3_bucket" {
  # Point CNAME record in Cloudflare to Cloudfront
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.s3_cdn_name
  value   = aws_cloudfront_distribution.main.domain_name
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "random_id" "argo_secret" {
  byte_length = 35
}

resource "cloudflare_argo_tunnel" "tunnel" {
  account_id = var.cloudflare_account_id
  name       = "${var.name}-aws-tunnel"
  secret     = random_id.argo_secret.b64_std
}

resource "cloudflare_record" "tunnel_dns" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.site_domain
  value   = "${cloudflare_argo_tunnel.tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "bean" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "bean.${var.site_domain}"
  value   = "${cloudflare_argo_tunnel.tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "beanweb" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "beanweb.${var.site_domain}"
  value   = "${cloudflare_argo_tunnel.tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_tunnel_config" "tunnel_route" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_argo_tunnel.tunnel.id

  config {
    ingress_rule {
      hostname = "jinwei.me"
      path     = "/"
      service  = "http://127.0.0.1:30081"
    }
    ingress_rule {
      hostname = "bean.jinwei.me"
      path     = "/"
      service  = "http://127.0.0.1:30082"
    }
    ingress_rule {
      hostname = "beanweb.jinwei.me"
      path     = "/"
      service  = "http://127.0.0.1:30083"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "aws_ssm_parameter" "cloudflare_tunnel_token" {
  name  = "/${local.name}/cloudflare/tunnel_token"
  type  = "SecureString"
  value = cloudflare_argo_tunnel.tunnel.tunnel_token
}

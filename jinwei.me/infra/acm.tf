resource "aws_acm_certificate" "main" {
  domain_name       = "static.jinwei.me"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.static.jinwei.me",
  ]
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [cloudflare_record.acm.hostname]
}


# CloudFront requires ACM to be in us-east-1, so duplicate the resources.
resource "aws_acm_certificate" "us-east-1" {
  provider = aws.us-east-1

  domain_name       = "static.jinwei.me"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.static.jinwei.me",
  ]
}

resource "aws_acm_certificate_validation" "us-east-1" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.us-east-1.arn
  validation_record_fqdns = [cloudflare_record.acm.hostname]
}

# Cloudflare validation record
resource "cloudflare_record" "acm" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name   = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_name
  type   = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_type
  value  = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_value
}

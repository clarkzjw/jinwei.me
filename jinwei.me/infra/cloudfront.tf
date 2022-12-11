resource "aws_cloudfront_distribution" "main" {
  aliases             = [var.s3_cloudfront_name]
  enabled             = true
  http_version        = "http2and3"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = true
  wait_for_deployment = false

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.main.bucket_regional_domain_name

    compress                 = true
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    cache_policy_id          = data.aws_cloudfront_cache_policy.managed["CachingOptimized"].id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed["CORS-S3Origin"].id
  }

  origin {
    origin_id                = aws_s3_bucket.main.bucket_regional_domain_name
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.us-east-1.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = var.s3_cloudfront_name
  description                       = var.s3_cloudfront_name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Managed policies
locals {
  managed_cache_policies = [
    "Amplify",
    "CachingDisabled",
    "CachingOptimized",
    "CachingOptimizedForUncompressedObjects",
    "Elemental-MediaPackage",
  ]
  managed_origin_request_policies = [
    "AllViewer",
    "CORS-CustomOrigin",
    "CORS-S3Origin",
    "Elemental-MediaTailor-PersonalizedManifests",
    "UserAgentRefererHeaders",
  ]
}

data "aws_cloudfront_cache_policy" "managed" {
  for_each = toset(local.managed_cache_policies)

  name = "Managed-${each.key}"
}

data "aws_cloudfront_origin_request_policy" "managed" {
  for_each = toset(local.managed_origin_request_policies)

  name = "Managed-${each.key}"
}

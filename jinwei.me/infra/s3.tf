resource "random_id" "s3_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "main" {
  bucket = "static.jinwei.me"
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html
  block_public_acls       = false
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  # Allow Cloudflare to read from the bucket
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.main.arn}/*",
    ]
    condition {
      test     = "IpAddress"
      variable = "AWS:SourceIp"
      values   = data.cloudflare_ip_ranges.cloudflare.cidr_blocks
    }
  }
}

resource "aws_s3_object" "healthcheck" {
  bucket       = aws_s3_bucket.main.id
  key          = "healthcheck"
  content      = "OK"
  content_type = "text/plain"
}

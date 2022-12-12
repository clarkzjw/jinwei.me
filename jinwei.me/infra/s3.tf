resource "random_id" "s3_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static" {
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html#:~:text=For%20best%20compatibility,in%20their%20names
  bucket = "${var.name}-${random_id.s3_bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "static" {
  bucket = aws_s3_bucket.static.id

  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html
  block_public_acls       = false
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "static" {
  bucket = aws_s3_bucket.static.id
  policy = data.aws_iam_policy_document.static_bucket_policy.json
}


data "aws_iam_policy_document" "static_bucket_policy" {
  # Allow Cloudfront to read from the bucket
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
      "${aws_s3_bucket.static.arn}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.main.arn]
    }
  }
}

resource "aws_s3_object" "check" {
  bucket       = aws_s3_bucket.static.id
  key          = "healthcheck"
  content      = "OK"
  content_type = "text/plain"
}

resource "aws_s3_object" "ping" {
  bucket       = aws_s3_bucket.static.id
  key          = "ping"
  content      = "pong"
  content_type = "text/plain"
}

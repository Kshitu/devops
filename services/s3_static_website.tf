resource "aws_s3_bucket" "chasing_horizons_website_bucket" {
  bucket = "chasing-horizons"
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.chasing_horizons_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

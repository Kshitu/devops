resource "aws_iam_role" worker_role {
  name = "worker-role"
  assume_role_policy = templatefile("policies/trust-policy.tpl", {
    principal_service = aws_iam_user.worker_user.arn
  })
}

resource "aws_iam_policy" "worker_s3_full_access" {
name        = "worker-s3-full-access"
  description = "Grants full access to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:*"
        ],
        Resource = [
          "arn:aws:s3:::chasing_horizons_website_bucket",
          "arn:aws:s3:::chasing_horizons_website_bucket/*"
        ]
      }
    ]
  })
}

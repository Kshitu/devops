resource "aws_iam_role" worker_role {
  name = "worker-role"
  assume_role_policy = templatefile("policies/trust-policy.tpl", {
    principal_service = aws_iam_user.worker_user.arn
  })
}

resource "aws_iam_policy" "worker_s3_full_access" {
  name        = "worker-s3-full-access"
  description = "Grants full access to the chasing-horizons S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:*"
        ],
        Resource = [
          "arn:aws:s3:::chasing-horizons",
          "arn:aws:s3:::chasing-horizons/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker_role_s3_access_attachment" {
  policy_arn = aws_iam_policy.worker_s3_full_access.arn
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_policy" "worker_cloudfront_access" {
  name        = "worker-cloudfront-access"
  description = "Allows access to CloudFront distributions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "cloudfront:ListDistributions",
          "cloudfront:GetDistribution",
          "cloudfront:ListInvalidations"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker_role_cloudfront_access_attachment" {
  policy_arn = aws_iam_policy.worker_cloudfront_access.arn
  role       = aws_iam_role.worker_role.name
}

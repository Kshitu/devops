resource "aws_iam_role" "github_actions_oidc_role" {
  name               = "github-actions-oidc-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action    = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = "repo:kshitu/devops:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}



resource "aws_iam_role_policy" "github_actions_policy" {
  role   = aws_iam_role.github_actions_oidc_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket",
          "s3:PutObject",
          "cloudfront:CreateDistribution",
          "cloudfront:UpdateDistribution",
          "cloudfront:GetDistribution"
        ]
        Resource = "*"
      }
    ]
  })
}


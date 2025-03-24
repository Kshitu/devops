resource "aws_iam_user" "worker_user" {
  name = var.worker_user
}

# enable console access
resource "aws_iam_user_login_profile" "worker_user_profile" {
  user                    = aws_iam_user.worker_user.name
  password_reset_required = true
}

# generate random password
resource "random_password" "worker_user_password" {
  length           = 16
  special          = true
  override_special = "!@#?"
}

# Output IAM user credentials
# NOTE: terraform output -raw worker_user_credentials to view creds
output "worker_user_credentials" {
  value     = <<EOT
User: ${aws_iam_user.worker_user.name}
Password: ${random_password.worker_user_password.result}
Login URL: https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console
EOT
  sensitive = true
}




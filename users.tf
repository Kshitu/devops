resource "aws_iam_user" "worker_user" {
  name = var.worker_user
}

# enable console access
resource "aws_iam_user_login_profile" "worker_user_profile" {
  user                    = aws_iam_user.worker_user.name
  password_reset_required = true
}


# Output IAM user credentials
# NOTE: terraform output -raw worker_user_credentials to view creds
#output "worker_user_credentials" {
#  value     = <<EOT
#User: ${aws_iam_user.worker_user.name}
#Password: ${random_password.worker_user_password.result}
#Login URL: https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console
#EOT
#  sensitive = true
#}
#
#resource "aws_ses_email_identity" "sender" {
#  email = "your-verified-email@example.com"
#}
#
#resource "aws_ses_template" "login_email" {
#  name    = "LoginDetailsTemplate"
#  subject = "Your AWS IAM Login Credentials"
#  html    = <<EOT
#    <h3>Your AWS IAM Login Credentials</h3>
#    <p><b>User:</b> ${aws_iam_user.worker_user.name}</p>
#    <p><b>Login URL:</b> <a href="https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console">
#    Click here to login</a></p>
#    <p>You will be asked to reset your password on first login.</p>
#  EOT
#  text = <<EOT
#    Your AWS IAM Login Credentials:
#    User: ${aws_iam_user.worker_user.name}
#    Login URL: https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console
#    You will be asked to reset your password on first login.
#  EOT
#}
#
#resource "null_resource" "send_email" {
#  depends_on = [aws_ses_template.login_email, aws_iam_user.worker_user]
#
#  provisioner "local-exec" {
#    command = <<EOT
#      aws ses send-templated-email \
#        --profile admin-user \
#        --source "miss.nagaraj+123@gmail.com" \
#        --destination '{"ToAddresses":["miss.nagaraj+456@gmail.com"]}' \
#        --template "LoginDetailsTemplate" \
#        --template-data '{ "name": "${aws_iam_user.worker_user.name}", "account_id": "${data.aws_caller_identity.current.account_id}" }'
#    EOT
#  }
#}
#
#
#

# was just simpler
#aws iam update-login-profile \
#  --user-name worker-user \
#  --password "NewSecurePassword123" \
#  --no-password-reset-required \



output "iam_role_github_actions_arn" {
  value = aws_iam_role.github_actions.arn
}

output "iam_role_lambda_arn" {
  value = aws_iam_role.lambda.arn
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.serverless_s3.arn
}

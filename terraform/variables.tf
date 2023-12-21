variable "iam_role_name" {
  description = "IAM role 이름"
  type        = string
}

variable "github_repos" {
  description = "Github repository"
  type        = list(string)
}

variable "serverless_s3" {
  description = "serverless stack을 저장할 s3"
  type        = string
}

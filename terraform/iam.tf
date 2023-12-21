////
// github action IAM role
////

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
}

data "tls_certificate" "oidc_thumbprint" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name               = "github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume.json
}

data "aws_iam_policy_document" "github_actions_assume" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repos
    }
  }
}

resource "aws_iam_role_policy_attachment" "github_action_ecr_push" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_action_ecr.arn
}

resource "aws_iam_policy" "github_action_ecr" {
  name        = "github-action-ecr"
  policy      = data.aws_iam_policy_document.github_action_ecr.json
}

data "aws_iam_policy_document" "github_action_ecr" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [aws_ecr_repository.github-action-test.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "github_action_lambda" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_action_lambda.arn
}

resource "aws_iam_policy" "github_action_lambda" {
  name        = "github-action-lambda"
  policy      = data.aws_iam_policy_document.github_action_lambda.json
}

data "aws_iam_policy_document" "github_action_lambda" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    actions = [
      "lambda:AddPermission",
      "lambda:CreateFunction",
      "lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
      "lambda:ListTags",
      "lambda:ListVersionsByFunction",
      "lambda:PublishVersion",
      "lambda:PutFunctionCodeSigningConfig",
      "lambda:UpdateFunctionCode",
      "lambda:DeleteFunction",
      "iam:PassRole"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "github_action_cloudfromation" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_action_cloudfromation.arn
}

resource "aws_iam_policy" "github_action_cloudfromation" {
  name        = "github-action-cloudformation"
  policy      = data.aws_iam_policy_document.github_action_cloudfromation.json
}

data "aws_iam_policy_document" "github_action_cloudfromation" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    actions = [
      "cloudformation:Describe*",
      "cloudformation:List*",
      "cloudformation:Get*",
      "cloudformation:PreviewStackUpdate",
      "cloudformation:CreateStack",
      "cloudformation:UpdateStack",
      "cloudformation:DeleteStack"
    ]

    resources = ["*"]
  }
}

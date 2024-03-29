# 실행 방법
* terraform.tfvar에서 변수 설정
  * github_repos를 자신의 github repo로 수정
  * S3 버킷 이름 수정
* terraform plan && apply

# 참고자료
* https://gruntwork.io/repos/v0.62.1/module-security/modules/github-actions-iam-role
* https://www.automat-it.com/post/using-github-actions-with-aws-iam-roles
* https://github.com/voquis/terraform-aws-github-actions-oidc-role/blob/main/main.tf
* https://zerone-code.tistory.com/11
* ECR IAM policy: https://github.com/aws/aws-toolkit-azure-devops/issues/311#issuecomment-623871181
* lambda IAM policy: https://alsmola.medium.com/github-actions-signing-lambda-code-5b7444299b
* cloudformation IMA policy: https://sst.dev/archives/customize-the-serverless-iam-policy.html
* serverless.yml 필드: https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml
* lambda IAM policy: https://www.serverless.com/framework/docs/providers/aws/guide/iam

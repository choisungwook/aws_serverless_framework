# 개요
* serverless로 lambda, alb배포

# 실행 방법
* serverless 설치

```bash
npm install serverless
```

* serverless.yml에서 vpc id, subnet id 수정

```yaml
# 아래 검색해서 subnet id 수정
Subnets:
  - subnet-089714c3b311713da
  -	subnet-0e52034bc9dd0cd15

# 아래 검색해서 vpc id 수정
VpcId: vpc-05db3161b9a1d612b
```

* 도메인과 ACM 설정

```bash
export ROUTE53_HOSTED_ZONE_ID=""
export ROUTE53_NAME=""
export ACM_ARN=""
```

* serverless 실행

```bash
sls deploy
```

# 삭제

```bash
sls remove
```

# 참고자료
* https://serverlessland.com/patterns/alb-lambda-rust
* https://serverlessland.com/patterns/alb-lambda-sls-framework
* https://gist.github.com/rwestergren/7bf8c7f7ef5c10b93a6101c9fb8cd56b
* https://medium.com/dazn-tech/serverless-aws-latency-routing-d11d9160699e

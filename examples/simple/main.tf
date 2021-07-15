module "codebuild_sqitch_shared_resources" {
  source      = "../../"
  product     = "lending"
  environment = "stg"
  vpc_id      = data.aws_vpc.this.id
}

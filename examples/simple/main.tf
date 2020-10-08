module "codebuild_sqitch_shared_resources" {
  source         = "../../"
  product_domain = "bei"
  environment    = "staging"
  vpc_id         = "${data.terraform_remote_state.vpc_lab_production.vpc_id}"
}

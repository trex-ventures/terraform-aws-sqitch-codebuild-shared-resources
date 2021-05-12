output "codebuild_role_arn" {
  value       = "${module.codebuild_sqitch_shared_resources.codebuild_role_arn}"
  description = "The sqitch codebuild role's ARN"
}

output "postgres_security_group_id" {
  value       = "${module.codebuild_sqitch_shared_resources.postgres_security_group_id}"
  description = "The ID for postgres-sqitch security group. Attach this to all RDS instances that uses sqitch codebuild pipeline"
}

output "codebuild_security_group_id" {
  value       = "${module.codebuild_sqitch_shared_resources.codebuild_security_group_id}"
  description = "The ID for codebuild-sqitch security group. Use this when creating sqitch codebuild pipelines"
}

output "codebuild_role_name" {
  value       = "${module.codebuild_sqitch_shared_resources.codebuild_role_name}"
  description = "The sqitch codebuild role's Name"}

# Codebuild Role
module "codebuild_role" {
  source         = "github.com/traveloka/terraform-aws-iam-role.git//modules/service?ref=v1.0.2"
  product_domain = "${var.product_domain}"
  environment    = "${var.environment}"

  role_identifier            = "${var.product_domain}-codebuild-sqitch-role"
  role_description           = "Service Role for CodeBuild Sqitch pipeline"
  role_force_detach_policies = "true"
  role_tags                  = "${var.additional_tags}"

  aws_service = "codebuild.amazonaws.com"
}

# Codebuild role IAM policy
resource "aws_iam_role_policy" "main" {
  name   = "${module.codebuild_role.role_name}-main"
  role   = "${module.codebuild_role.role_name}"
  policy = "${data.aws_iam_policy_document.this.json}"
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr" {
  role       = "${module.codebuild_role.role_name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Security Group Name
module "postgres_sg_name" {
  source        = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.18.1"
  name_prefix   = "${var.product_domain}-postgres-sqitch-sg"
  resource_type = "security_group" 
} 

module "codebuild_sg_name" {
  source        = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.18.1"
  name_prefix   = "${var.product_domain}-codebuild-sqitch-sg"
  resource_type = "security_group" 
}

# Security Group
resource "aws_security_group" "codebuild_sqitch" {
  name        = "${module.codebuild_sg_name.name}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.product_domain}-codebuild-sqitch security group"

  tags = {
    Name          = "${module.codebuild_sg_name.name}"
    Service       = "${var.product_domain}-codebuild-sqitch"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.product_domain}-codebuild-sqitch pipeline"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "postgres_sqitch" {
  name        = "${module.postgres_sg_name.name}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.product_domain}-postgres-sqitch security group to be attached to RDS instances"

  tags = {
    Name          = "${module.postgres_sg_name.name}"
    Service       = "${var.product_domain}-postgres-sqitch"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.product_domain}-postgres-sqitch to be attached to RDS instances"
    ManagedBy     = "terraform"
  }
}

# Security Group Rules
resource "aws_security_group_rule" "codebuild_sqitch_https_all" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.codebuild_sqitch.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress from ${var.product_domain}-codebuild-sqitch to all in 443"
}

resource "aws_security_group_rule" "egress_from_codebuild_sqitch_to_postgres_5432" {
  type                     = "egress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.codebuild_sqitch.id}"
  source_security_group_id = "${aws_security_group.postgres_sqitch.id}"
  description              = "Egress from ${var.product_domain}-codebuild-sqitch to ${var.product_domain}-postgres-sqitch in 5432"
}

resource "aws_security_group_rule" "ingress_for_postgres_from_codebuild_sqitch_5432" {
  type                     = "ingress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.postgres_sqitch.id}"
  source_security_group_id = "${aws_security_group.codebuild_sqitch.id}"
  description              = "ingress for ${var.product_domain}-postgres-sqitch from ${var.product_domain}-codebuild-sqitch in 5432"
}


# Codebuild Role
resource "random_id" "codebuild_role" {
  prefix = format("%s-%s-", var.product, var.service_name)
  keepers = {
    product = var.product
  }

  byte_length = 8
}

module "codebuild_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.0"

  create_role           = true
  force_detach_policies = true
  role_name             = random_id.codebuild_role.hex
  role_path             = "/service/codebuild/"
  role_requires_mfa     = false
  role_description      = "Service Role for CodeBuild Sqitch pipeline"
  trusted_role_services = [
    "codebuild.amazonaws.com"
  ]
}

# Codebuild role IAM policy
resource "aws_iam_role_policy" "main" {
  name   = "${module.codebuild_role.iam_role_name}-main"
  role   = module.codebuild_role.iam_role_name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr" {
  role       = module.codebuild_role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy" "allow_use_cmk" {
  count = (length(var.key_arns) > 0) ? 1 : 0

  name   = "${module.codebuild_role.iam_role_name}-allow-use-cmk"
  role   = module.codebuild_role.iam_role_name
  policy = data.aws_iam_policy_document.allow_cmk.json
}

# Security Group Name
resource "random_id" "codebuild_sg" {
  prefix = format("%s-%s-", var.product, var.service_name)
  keepers = {
    product = var.product
  }

  byte_length = 8
}

resource "random_id" "postgres_sg" {
  prefix = format("%s-%s-", var.product, var.service_name)
  keepers = {
    product = var.product
  }

  byte_length = 8
}

# Security Group
resource "aws_security_group" "codebuild_sqitch" {
  name        = random_id.codebuild_sg.hex
  vpc_id      = var.vpc_id
  description = "${var.product}-codebuild-sqitch security group"

  tags = {
    Description = "Security group for ${var.product}-codebuild-sqitch pipeline"
  }
}

resource "aws_security_group" "postgres_sqitch" {
  name        = random_id.postgres_sg.hex
  vpc_id      = var.vpc_id
  description = "${var.product}-postgres-sqitch security group to be attached to RDS instances"

  tags = {
    Description = "Security group for ${var.product}-postgres-sqitch to be attached to RDS instances"
  }
}

# Security Group Rules
resource "aws_security_group_rule" "codebuild_sqitch_https_all" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  security_group_id = aws_security_group.codebuild_sqitch.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress from ${var.product}-codebuild-sqitch to all in 443"
}

resource "aws_security_group_rule" "egress_from_codebuild_sqitch_to_postgres_5432" {
  type                     = "egress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.codebuild_sqitch.id
  source_security_group_id = aws_security_group.postgres_sqitch.id
  description              = "Egress from ${var.product}-codebuild-sqitch to ${var.product}-postgres-sqitch in 5432"
}

resource "aws_security_group_rule" "ingress_for_postgres_from_codebuild_sqitch_5432" {
  type                     = "ingress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.postgres_sqitch.id
  source_security_group_id = aws_security_group.codebuild_sqitch.id
  description              = "ingress for ${var.product}-postgres-sqitch from ${var.product}-codebuild-sqitch in 5432"
}


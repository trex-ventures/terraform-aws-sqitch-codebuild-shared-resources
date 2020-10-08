variable "product_domain" {
  type        = "string"
  description = "product domain of the role owner"
}

variable "vpc_id" {
  type        = "string"
  description = "the VPC ID where the security groups will be put. Use vpc_id output from the vpc terraform module"
}

variable "environment" {
  type        = "string"
  description = "the environment where the role and security groups are put"
}

variable "additional_tags" {
  type        = "map"
  description = "additional tags for the shared resources"
  default     = {}
}


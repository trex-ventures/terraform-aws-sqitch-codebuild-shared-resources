variable "product" {
  type        = string
  description = "product domain of the role owner"
}

variable "service_name" {
  type        = string
  description = "name of the service"
  default     = "sqitch"
}

variable "vpc_id" {
  type        = string
  description = "the VPC ID where the security groups will be put. Use vpc_id output from the vpc terraform module"
}

variable "environment" {
  type        = string
  description = "the environment where the role and security groups are put"
}

variable "additional_tags" {
  type        = map(string)
  description = "additional tags for the shared resources"
  default     = {}
}

variable "key_arns" {
  type        = list(string)
  description = "List of all AWS KMS Customer Managed Key ARNs that this role can use"
  default     = []
}

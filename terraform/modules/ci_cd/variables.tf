variable "aws_region" {
  default = "us-east-1"
}

variable "lb_target_group_name" {
  description = "The name of the ALB target group"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket used as artifact store for CodePipeline"
  type        = string
}
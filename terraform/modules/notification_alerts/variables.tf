variable "aws_region" {
  default = "us-east-1"
}

variable "notification_email" {
    description = "Pipeline failure reports will be sent here"
    type = string
    default = "sadarsh460@gmail.com"
}
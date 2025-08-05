terraform {
  backend "s3" {
    bucket         = "webapp-backend-tf-state-bucket-12345"
    key            = "devops-app/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "webapp-backend-terraform-lock-table"
  }
}
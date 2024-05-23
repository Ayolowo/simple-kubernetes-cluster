provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    bucket         = "remote-backend-for-state"
    key            = "global/s3/terraform.tf.state"
    region         = "us-east-1"
    dynamodb_table = "terraform-locking"
    encrypt        = true
  }
}

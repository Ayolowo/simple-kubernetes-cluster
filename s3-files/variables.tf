variable "region" {
  default = "us-east-1"
}


variable "bucket_name" {
  default = "remote-backend-for-state"
}


variable "aws_dynamodb_table" {
  default = "terraform-locking"
}

# To create an S3 bucket    
resource "aws_s3_bucket" "remote-backend-for-state" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Enabling versioning on our s3 bucket
resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

# Kms key used to encrypt bucket objects + Server side encryption
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encrypt" {
  bucket = var.bucket_name
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


# To create a dynamodb table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.aws_dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


# Reference an existing S3 bucket instead of creating a new one
data "aws_s3_bucket" "existing_bucket" {
  bucket = "vicdeb-bucket"  # Use the existing bucket name
}

# Enable Versioning for Terraform State Management
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = data.aws_s3_bucket.existing_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption for Security
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = data.aws_s3_bucket.existing_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}



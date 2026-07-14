# 1. Create the S3 Bucket
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "enterprise-finance-data-0001"

# EXCEPTION HANDLING: Suppressing strict enterprise checks for this portfolio demo
  #checkov:skip=CKV_AWS_18: Access logging not required for this demo
  #checkov:skip=CKV_AWS_144: Cross-region replication not required
  #checkov:skip=CKV_AWS_145: AES256 encryption is sufficient, KMS not required
  #checkov:skip=CKV2_AWS_61: Lifecycle configuration not required
  #checkov:skip=CKV2_AWS_62: Event notifications not required
  #checkov:skip=CKV2_AWS_65: Explicit private ACL is acceptable for this demo
}

# 2. Configure Ownership Controls
resource "aws_s3_bucket_ownership_controls" "insecure_bucket_ownership" {
  bucket = aws_s3_bucket.insecure_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# 3. The Trap: Deliberately disabling the Public Access Block
# 3a. The Fix: Enabling the Public Access Block
resource "aws_s3_bucket_public_access_block" "insecure_bucket_access" {
  bucket = aws_s3_bucket.insecure_bucket.id

  #block_public_acls       = false
  #block_public_policy     = false
  #ignore_public_acls      = false
  #restrict_public_buckets = false

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true  
}

# 4. The Trap: Explicitly setting the Access Control List (ACL) to Public Read
# 4a. The Fix: Explicitly setting the Access Control List (ACL) to Private
resource "aws_s3_bucket_acl" "insecure_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.insecure_bucket_ownership,
    aws_s3_bucket_public_access_block.insecure_bucket_access,
  ]

  bucket = aws_s3_bucket.insecure_bucket.id
  #acl    = "public-read"
  acl    = "private"
}

# 5. Remediation: Enabling Versioning (Ransomware protection)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.insecure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 6. REMEDIATION: Enabling Server-Side Encryption (Data-at-rest protection)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.insecure_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
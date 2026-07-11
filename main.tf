provider "aws" {
region = "us-east-1"
}

# 1. Create the S3 Bucket

resource "aws_s3_bucket" "insecure_bucket" {
    bucket = "enterprise-finance-data-12345"
}

# 2. Configure Ownership Controls

resource "aws_s3_bucket_ownership_controls" "insecure_bucket_ownership" {
bucket = aws_s3_bucket.insecure_bucket.id
rule {
object_ownership = "BucketOwnerPreferred"
}
}

# 3. The Trap: Deliberately disabling the Public Access Block

resource "aws_s3_bucket_public_access_block" "insecure_bucket_access" {
bucket = aws_s3_bucket.insecure_bucket.id

block_public_acls       = false
block_public_policy     = false
ignore_public_acls      = false
restrict_public_buckets = false
}

# 4. The Trap: Explicitly setting the Access Control List (ACL) to Public Read

resource "aws_s3_bucket_acl" "insecure_bucket_acl" {
depends_on = [
aws_s3_bucket_ownership_controls.insecure_bucket_ownership,
aws_s3_bucket_public_access_block.insecure_bucket_access,
]

bucket = aws_s3_bucket.insecure_bucket.id
acl    = "public-read"
}
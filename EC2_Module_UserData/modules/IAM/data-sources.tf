#Fetch IAM Policy - S3FullAccess
data "aws_iam_policy" "s3_full_access_policy" {
  name = "AmazonS3FullAccess"
}
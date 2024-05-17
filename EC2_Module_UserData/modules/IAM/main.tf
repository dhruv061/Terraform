#Create IAM Role
resource "aws_iam_role" "s3_access_role" {
  name               = var.iam_role_name
  #trust policy
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

#Attach Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "s3_fullaccess_attachment" {
  role = aws_iam_role.s3_access_role.name
  #Policy ARN get from IAM console inside policy section 
  #S3 full access policy
  policy_arn = data.aws_iam_policy.s3_full_access_policy.arn
}

#Create Instace Profile that is used to assign this role into the EC2 instace.
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.s3_access_role.name
}
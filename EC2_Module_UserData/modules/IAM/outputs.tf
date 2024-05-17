output "iam_role_arn" {
  value = aws_iam_role.s3_access_role.arn
}

output "iam_instace_profile" {
  value = aws_iam_instance_profile.ec2_s3_profile.name
}
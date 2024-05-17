output "iam_role_arn" {
  value = aws_iam_role.s3_access_role.arn
}

output "public_ip" {
  value = aws_instance.myec2.public_ip
}

output "public_ip" {
  value = aws_instance.myec2.public_ip
}

output "ec2_id" {
  value = aws_instance.myec2.id
}

#----------------------Export VPC value so that is used in LB & TG module---------------------------------------#
output "vpc_id" {
  value = data.aws_vpc.myvpc.id
}

output "subnet_1_id" {
  value = data.aws_subnet.my_subnet_1.id
}

output "subnet_2_id" {
  value = data.aws_subnet.my_subnet_2.id
}
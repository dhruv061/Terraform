output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_subnet_id_1" {
  value = aws_subnet.public-subnet-1.id
}

output "vpc_subnet_id_2" {
  value = aws_subnet.public-subnet-2.id
}

output "vpc_sg" {
  value = aws_security_group.vpc_sg.id
}
#VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Availability Zones
output "availability_zones" {
  description = "List of available availability zones"
  value       = data.aws_availability_zones.az.names
}

#Subnet-ID'S
output "subnet_details" {
  description = "Details of the public and private subnets"
  value = {
    public_subnets = {
      ids                 = aws_subnet.public[*].id
      cidr_blocks         = aws_subnet.public[*].cidr_block
      availability_zones  = aws_subnet.public[*].availability_zone
    }
    private_subnets = {
      ids                 = aws_subnet.private[*].id
      cidr_blocks         = aws_subnet.private[*].cidr_block
      availability_zones  = aws_subnet.private[*].availability_zone
    }
  }
}

#IGW ID
output "igw_id" {
  description = "The ID of the Internet Gatway"
  value       = aws_internet_gateway.gw.id
}

#NAT Gateway Id
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}
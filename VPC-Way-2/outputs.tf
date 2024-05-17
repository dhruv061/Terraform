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

#Public Subnet-Deatils
output "public_subnet_details" {
  description = "Details of the public and private subnets"
  value = {
    public_subnets_1 = {
      ids                = aws_subnet.public-subnet-1.id
      cidr_blocks        = aws_subnet.public-subnet-1.cidr_block
      availability_zones = aws_subnet.public-subnet-1.availability_zone
    }
    public_subnets_2 = {
      ids                = aws_subnet.public-subnet-2.id
      cidr_blocks        = aws_subnet.public-subnet-2.cidr_block
      availability_zones = aws_subnet.public-subnet-2.availability_zone
    }
    public_subnets_3 = {
      ids                = aws_subnet.public-subnet-3.id
      cidr_blocks        = aws_subnet.public-subnet-3.cidr_block
      availability_zones = aws_subnet.public-subnet-3.availability_zone
    }
  }
}

#Private Subnet-Deatils
output "private_subnet_details" {
  description = "Details of the public and private subnets"
  value = {
    private_subnets_1 = {
      ids                = aws_subnet.private-subnet-1.id
      cidr_blocks        = aws_subnet.private-subnet-1.cidr_block
      availability_zones = aws_subnet.private-subnet-1.availability_zone
    }
    private_subnet_2 = {
      ids                = aws_subnet.private-subnet-2.id
      cidr_blocks        = aws_subnet.private-subnet-2.cidr_block
      availability_zones = aws_subnet.private-subnet-2.availability_zone
    }
    private_subnets_3 = {
      ids                = aws_subnet.private-subnet-3.id
      cidr_blocks        = aws_subnet.private-subnet-3.cidr_block
      availability_zones = aws_subnet.private-subnet-3.availability_zone
    }
  }
}

#IGW ID
output "igw_id" {
  description = "The ID of the Internet Gatway"
  value       = aws_internet_gateway.igw.id
}

#NAT Gateway Id
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}
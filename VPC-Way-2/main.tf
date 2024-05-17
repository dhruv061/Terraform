#----------------------------------------------For Create VPC-------------------------------------------------#
# Step-1:Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Dhruv-VPC"
  }
}

# Subnet Configuration
# Step-2: create 3 public subnets & 3 privatefor 3 diffrent AZ [Each AZ get 2 subnet one public & one private]
# Public Subnet's
# Public Subnet-1
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.az.names[0]
  #This is enable to attach IGW (it's make this all subnets public)
  map_public_ip_on_launch = true

  tags = {
    Name = "Dhruv-PublicSubnet-1"
  }
}

# Public Subnet-2
resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.az.names[1]
  #This is enable to attach IGW (it's make this all subnets public)
  map_public_ip_on_launch = true

  tags = {
    Name = "Dhruv-PublicSubnet-2"
  }
}

# Public Subnet-3
resource "aws_subnet" "public-subnet-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[2]
  availability_zone = data.aws_availability_zones.az.names[2]
  #This is enable to attach IGW (it's make this all subnets public)
  map_public_ip_on_launch = true

  tags = {
    Name = "Dhruv-PublicSubnet-3"
  }
}

# Private Subnet's
# Private Subnet-1
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.az.names[0]

  tags = {
    Name = "Dhruv-PrivateSubnet-1"
  }
}

# Private Subnet-2
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.az.names[1]

  tags = {
    Name = "Dhruv-PrivateSubnet-2"
  }
}

# Private Subnet-3
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[2]
  availability_zone = data.aws_availability_zones.az.names[2]

  tags = {
    Name = "Dhruv-PrivateSubnet-3"
  }
}

# Step-3: Create IGW (Internet Gateway)
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  tags = {
    Name = "Dhruv-InternetGateway"
  }
}

# Step 04. Create Public and Private Route Table with it's route
#Step 04 (A): Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Dhruv-PublicRouteTable"
  }
}

# Create default public route
resource "aws_route" "public_default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.public_rt_destination_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

#Step 04 (B): Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Dhruv-PrivateRouteTable"
  }
}

# Private route 
resource "aws_route" "private_default_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = var.private_rt_destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.nat.id #created in step-7
}

# Step 06 (A). Add Public Subnet in Public Route table
# public subnet-1 added in public route table
resource "aws_route_table_association" "public_subnet_association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public_route_table.id
}

# public subnet-2 added in public route table
resource "aws_route_table_association" "public_subnet_association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public_route_table.id
}

# public subnet-3 added in public route table
resource "aws_route_table_association" "public_subnet_association-3" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public_route_table.id
}

# Step 06 (B). Add Private Subnet in Private Route table
# private subnet-1 added in private route table
resource "aws_route_table_association" "private_subnet_association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private_route_table.id
}

# private subnet-2 added in private route table
resource "aws_route_table_association" "private_subnet_association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private_route_table.id
}

# private subnet-3 added in private route table
resource "aws_route_table_association" "private_subnet_association-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private_route_table.id
}

#Step 7: Create a NAT Gateway in Public Subnet
#We create NAT Gateway in one public subnet and then we use this NAT Gateway in all 3 priate subnet
#Step 7(A): Create one EIP to our NAT Gatway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "Dhruv-EIP"
  }
}

#Step 7(B): Create one  NAT Gatway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet-1.id

  depends_on = [aws_eip.nat, aws_subnet.private-subnet-1, aws_subnet.private-subnet-2, aws_subnet.private-subnet-3]

  tags = {
    Name = "Dhruv-NAT-Gateway"
  }
}

# Step 8: Add NAT Gateway into the Private Route Table
# --> for this we added "NatGatewayId" with this NAT gateway in private route table in step-4 "Private route"

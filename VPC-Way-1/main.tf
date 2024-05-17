#----------------------------------------------For Create VPC-------------------------------------------------#
# Step-1:Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Dhruv-VPC"
  }
}

# Subnet Configuration
# Step-2: create 3 public subnets & 3 privatefor 3 diffrent AZ [Each AZ get 2 subnet one public & one private]
# subnet-1 --> 3 public subnet's
resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  #This is enable to attacj IGW (it's make this all subnets public)
  map_public_ip_on_launch = true

  tags = {
    Name = "Dhruv-PublicSubnet-${count.index + 1}"
  }
}

# Subnet-2 --> 3 private subnet's
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)

  tags = {
    Name = "Dhruv-PrivateSubnet-${count.index + 1}"
  }
}

# Step-3: Create IGW (Internet Gateway)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  tags = {
    Name = "Dhruv-InternetGateway"
  }
}

# Step 04. Create Public and Private Route Table with it's route
#Step 04 (A): Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Dhruv-PublicRouteTable"
  }
}

# Create default public route
resource "aws_route" "public_default" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.public_rt_destination_cidr_block
  gateway_id                = aws_internet_gateway.gw.id
}

#Step 04 (B): Private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Dhruv-PrivateRouteTable"
  }
}

# Private route 
resource "aws_route" "private_default" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = var.private_rt_destination_cidr_block
  nat_gateway_id            = aws_nat_gateway.nat.id #created in step-7
}

# Step 06 (A). Add Public Subnet in Public Route table
resource "aws_route_table_association" "public_subnet_association" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Step 06 (B). Add Private Subnet in Private Route table
resource "aws_route_table_association" "private_subnet_association" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
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

###########
# NETWORK #
###########


#####
#VPC#
#####

resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"

enable_dns_support = true
  enable_dns_hostnames = true

tags {
    Name = "client"
  }
}

##################
#Internet Gateway#
##################

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
        Name = "InternetGateway"
    }
}

resource "aws_route"  "route_public" {
        destination_cidr_block = "0.0.0.0/0"
        route_table_id = "${aws_route_table.public-subnet.id}"
        gateway_id = "${aws_internet_gateway.gw.id}"
}


#############
#Nat Gateway#
#############
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.eu-west-1a-public.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_route"  "route_private" {
        destination_cidr_block = "0.0.0.0/0"
        route_table_id = "${aws_route_table.private-subnet.id}"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
}

################
#Private Subnet#
################

resource "aws_subnet" "eu-west-1a-private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.1.1.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
   Name =  "Private1 Subnet"
  }
}

resource "aws_route_table" "private-subnet" {
      vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "private-subnet-1a" {
    subnet_id      = "${aws_subnet.eu-west-1a-private.id}"
    route_table_id = "${aws_route_table.private-subnet.id}"
}

resource "aws_main_route_table_association" "main" {
  vpc_id                 = "${aws_vpc.main.id}"
  route_table_id         = "${aws_route_table.private-subnet.id}"
}

###############
#Public Subnet#
###############

resource "aws_subnet" "eu-west-1a-public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.1.4.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
   Name =  "Public Subnet"
  }
}

resource "aws_route_table" "public-subnet" {
    vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "public-subnet" {
    subnet_id      = "${aws_subnet.eu-west-1a-public.id}"
    route_table_id = "${aws_route_table.public-subnet.id}"
}

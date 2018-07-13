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
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_route"  "route_private" {
        destination_cidr_block = "0.0.0.0/0"
        route_table_id = "${aws_route_table.private-subnet.id}"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
}


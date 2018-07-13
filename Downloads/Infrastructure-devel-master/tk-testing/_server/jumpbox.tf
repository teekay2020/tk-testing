
resource "aws_instance" "jumpbox" {
  ami                         = "${var.amis}"
  instance_type               = "${var.type}"

  availability_zone           = "eu-west-1a"
  subnet_id                   = "${aws_subnet.eu-west-1a-public.id}"
  key_name                    = "${var.key}"
  iam_instance_profile        = "${aws_iam_instance_profile.asg_profile.id}"
  tenancy                     = "default"
  source_dest_check           = "false"
  associate_public_ip_address = "false"

  lifecycle {
    ignore_changes            = [ "associate_public_ip_address" ]
  }

  vpc_security_group_ids      = [
    "${aws_security_group.jumpbox.id}"
  ]

  tags {
    Name = "Jumpbox"
  }
}

# Access from both public and private subnet
resource "aws_network_interface" "jumpbox-private" {
  subnet_id                   = "${aws_subnet.eu-west-1a-private.id}"
  security_groups             = ["${aws_security_group.jumpbox.id}"]
  source_dest_check           = "false"

  attachment {
    instance                  = "${aws_instance.jumpbox.id}"
    device_index              = 1
  }
}

resource "aws_eip" "jumpbox" {
  vpc                         = "true"
}

resource "aws_eip_association" "jumpbox" {
  instance_id                 = "${aws_instance.jumpbox.id}"
  allocation_id               = "${aws_eip.jumpbox.id}"
}

resource "aws_security_group" "jumpbox" {
  name                         = "tk_jumpbox_sg"
  description                  = "ElastiCache security group (Allow all from 10/16)"
  vpc_id                       = "${aws_vpc.main.id}"

  ingress {
    from_port            = 22
    to_port              = 22
    protocol             = "tcp"
    cidr_blocks          = [
      "10.0.0.0/16",
      "10.1.0.0/16",
      "80.82.136.68/32", #RPS/PhP Office router 
      "88.98.232.123/32", #Turbo @ Home
      "89.241.151.3/32" #TK @ home
  ]
}

  egress {
    from_port            = 0
    to_port              = 0
    protocol             = "-1"
    cidr_blocks          = ["10.0.0.0/16"]
  }
}

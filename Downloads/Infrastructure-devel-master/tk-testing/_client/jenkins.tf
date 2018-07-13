resource "aws_instance" "jenkins" {
  ami                         = "${var.amis}"
  instance_type               = "${var.type}"

  availability_zone           = "eu-west-1a"
  subnet_id                   = "${aws_subnet.eu-west-1a-private.id}"
  key_name                    = "${var.key}"
  tenancy                     = "default"
  associate_public_ip_address = "false"

  vpc_security_group_ids      = [
    "${aws_security_group.jenkins_sg.id}"
  ]

tags {
    Name = "Jenkins"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name                         = "tk_jenkins_sg"
  description                  = "ElastiCache security group (Allow all from 10/16)"
  vpc_id                       = "${aws_vpc.main.id}"
  ingress {
    from_port            = 22
    to_port              = 22
    protocol             = "TCP"
    cidr_blocks          = ["10.0.0.0/16"]
  }
 
  ingress {
    from_port            = 80
    to_port              = 80
    protocol             = "TCP"
    cidr_blocks          = ["10.0.0.0/16"]
  }

  egress {
    from_port            = 0
    to_port              = 0
    protocol             = "-1"
    cidr_blocks          = ["0.0.0.0/0"]
  }
}


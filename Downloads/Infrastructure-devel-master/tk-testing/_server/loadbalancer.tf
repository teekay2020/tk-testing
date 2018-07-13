resource "aws_lb" "tk_lb" {
  name            = "tk-lb-tf"
  internal        = true
  security_groups = [
     "${aws_security_group.lb_sg.id}"
  ]
 
  subnets         = [
     "${aws_subnet.eu-west-1a-private.id}",
     "${aws_subnet.eu-west-1b-private.id}",
     "${aws_subnet.eu-west-1c-private.id}"
  ]
}

resource "aws_security_group" "lb_sg" {
  name                         = "tk_lb_sg"
  description                  = "ElastiCache security group (Allow all from 10/16)"
  vpc_id                       = "${aws_vpc.main.id}"
  ingress {
    from_port            = 61613
    to_port              = 61613
    protocol             = "TCP"
    cidr_blocks          = ["10.0.0.0/16"]
  }

  egress {
    from_port            = 0
    to_port              = 0
    protocol             = "-1"
    cidr_blocks          = ["10.0.0.0/16"]
  }
}

resource "aws_lb_target_group" "tk_lb" {
  name     = "lb-tg"
  port     = 61613
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_lb_listener" "tk_lb" {
  load_balancer_arn = "${aws_lb.tk_lb.arn}"
  port              = 61613
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.tk_lb.arn}"
    type             = "forward"
  }
}


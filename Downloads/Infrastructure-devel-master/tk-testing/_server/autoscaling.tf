###########
#Autoscaling Group
###########

resource "aws_placement_group" "asg" {
  name     = "asg"
  strategy = "cluster"
}


resource "aws_launch_configuration" "asg" {
    name_prefix                 = "asg"
    image_id                    = "${var.amis}"
    instance_type               = "${var.type}"
    iam_instance_profile        = "${aws_iam_instance_profile.asg_profile.name}"
    key_name                    = "${var.key}"
    security_groups             = ["${aws_security_group.asg.id}"]
    associate_public_ip_address = false
    lifecycle {
      create_before_destroy = "true"
    }
}

resource "aws_autoscaling_group" "asg" {
  availability_zones        = ["eu-west-1a"]
  name                      = "asg"
  max_size                  = 0
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0
  force_delete              = true
  placement_group           = "${aws_placement_group.asg.id}"
  launch_configuration      = "${aws_launch_configuration.asg.name}"

#  initial_lifecycle_hook {
#    name                 = "asg"
#    default_result       = "CONTINUE"
#    heartbeat_timeout    = 2000
#    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#    notification_metadata = <<EOF
#{
#  "asg": "name"
#}
#EOF

#    notification_target_arn = "${aws_sns_topic.sns_tk.arn}"
#    role_arn                = "arn:aws:iam::783521761238:role/Cross_Account"
#  }

  tag {
    key                 = "state"
    value               = "autoscaling"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "asg" {
  name                         = "tk_asg_sg"
  description                  = "ElastiCache security group (Allow all from 10/16)"
  vpc_id                       = "${aws_vpc.main.id}"

  ingress {
    from_port            = 61613
    to_port              = 61613
    protocol             = "TCP"
    cidr_blocks          = ["10.0.0.0/16"]
  }

  ingress {
    from_port            = 22
    to_port              = 22
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

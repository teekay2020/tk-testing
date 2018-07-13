
resource "aws_iam_instance_profile" "asg_profile" {
  name  = "asg_profile"
  role = "${aws_iam_role.asg.name}"
}

resource "aws_iam_role_policy" "asg_access_policy" {
  name                        = "asg_access_policy"

  role                        = "${aws_iam_role.asg.id}"
  policy                      = <<EC2_ACTIONS_ACCESS_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeAddresses",
        "ec2:DescribeTags",
        "ec2:DescribeAvailabilityZones",
        "elasticloadbalancing:DescribeLoadBalancers",
        "iam:GetInstanceProfile"
      ],
      "Resource": "*"
    }
  ]
}
EC2_ACTIONS_ACCESS_POLICY
}


resource "aws_iam_role" "asg" {
  name = "asg_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                  "AWS": "*"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}


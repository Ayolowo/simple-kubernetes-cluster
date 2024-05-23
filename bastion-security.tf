resource "aws_security_group" "bastion_security_group" {
  name   = "bastion_security_group"
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_security_group_rule" "SSH" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["192.168.1.2/32"] # Restrict to a secure IP address or range
  security_group_id = aws_security_group.bastion_security_group.id
}

resource "aws_security_group_rule" "downloads" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_security_group.id
}

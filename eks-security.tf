# resource "aws_security_group_rule" "worker_node_sg_ingress" {
#   description       = "ssh access to public"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   security_group_id = module.eks
#   type              = "ingress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }



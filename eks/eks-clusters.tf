# Define the EKS cluster
resource "aws_eks_cluster" "my-eks-cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [var.subnet_ids[0], var.subnet_ids[1]]
  }

  depends_on = [
    aws_iam_role.eks_cluster_role,
    aws_iam_policy_attachment.AmazonEKSClusterPolicy
  ]
}


# Define the EKS node group
resource "aws_eks_node_group" "my-node-group" {
  cluster_name    = aws_eks_cluster.my-eks-cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_worker_node_role.arn

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t2.micro"]

  remote_access {
    ec2_ssh_key               = "my_key"
    source_security_group_ids = [var.sg_ids]
  }

  subnet_ids = [var.subnet_ids[0], var.subnet_ids[1]]

  depends_on = [
    aws_iam_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}

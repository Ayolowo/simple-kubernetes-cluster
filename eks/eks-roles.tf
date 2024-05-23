# Define the IAM role for the EKS cluster
# resource "aws_iam_role" "eks_cluster_role" {
#   name = "my-eks-cluster-role"

#   assume_role_policy = jsonencode(
#     { version = "2012-10-17", Statement = [{
#       Action = "sts:AssumeRole",
#       Effect = "Allow",
#       Principal = {
#         Service = ["eks.amazon.com"]
#       }
#     }] }
#   )
# }

# Attach the AmazonEKSClusterPolicy to the EKS cluster role
# resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
#   name       = "eks-cluster-attachment"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   roles      = [aws_iam_role.eks_cluster_role.name]
# }

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.id
}


# Define the IAM role for EKS worker nodes
resource "aws_iam_role" "eks_worker_node_role" {
  name = "eks-worker-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Attach necessary IAM policies to the EKS worker node role
# resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
#   name       = "eks-worker-node-attachment"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   roles      = aws_iam_role.eks_worker_node_role.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   name       = "eks-cni-attachment"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   roles      = aws_iam_role.eks_worker_node_role.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   name       = "eks-vpc-attachment"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   roles      = aws_iam_role.eks_worker_node_role.name
# }


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker_node_role.name
}

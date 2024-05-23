# Terraform Data Block - To Lookup Latest Ubuntu 20.04 AMI Image
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Terraform Resource Block - To Build EC2 instance in Public Subnet
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id
  vpc_security_group_ids      = [aws_security_group.bastion_security_group.id]
  tags = {
    Name = "bastion-instance"
  }
}

# To output private key for SSH access via Bastion host
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.my_key.public_key_openssh
}


output "private_key" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}

# Summary: See README.md

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    local = {
      version = "~> 1.4"
    }
    external = {
      version = "~> 1.2"
    }
    kubernetes = {
      version = "~> 1.10"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_eks/fargate/spot_and_fargate"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "kubernetes" {
  host                   = data.aws_eks_cluster.changeme_spot_and_fargate_eks_cluster_data.endpoint
  load_config_file       = false
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.changeme_spot_and_fargate_eks_cluster_data.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.changeme_spot_and_fargate_eks_cluster_auth_data.token
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_name" {
  description = "the name of your stack, e.g. \"demo\""
  default     = "eks-example"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "prod"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "us-east-1"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_spot_and_fargate_k8s_version" {
  description = "kubernetes version"
  default     = ""
}

# Documentation: https://www.terraform.io/docs/language/data-sources/index.html
data "aws_eks_cluster" "changeme_spot_and_fargate_eks_cluster_data" {
  name = aws_eks_cluster.changeme_spot_and_fargate_eks_cluster.id
}

# Documentation: https://www.terraform.io/docs/language/data-sources/index.html
data "aws_eks_cluster_auth" "changeme_spot_and_fargate_eks_cluster_auth_data" {
  name = aws_eks_cluster.changeme_spot_and_fargate_eks_cluster.id
}

# Fetch OIDC provider thumbprint for root CA
# Documentation: https://www.terraform.io/docs/language/data-sources/index.html
data "external" "changeme_external_thumbprint_data" {
  program    = ["${path.module}/oidc_thumbprint.sh", var.changeme_spot_and_fargate_region]
  depends_on = [aws_eks_cluster.changeme_spot_and_fargate_eks_cluster]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "changeme_spot_and_fargate_vpc" {
  cidr_block           = var.changeme_spot_and_fargate_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "changeme_spot_and_fargate_internet_gateway" {
  vpc_id = aws_vpc.changeme_spot_and_fargate_vpc.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "changeme_spot_and_fargate_nat_gateway" {
  count         = length(var.changeme_spot_and_fargate_private_subnets)
  allocation_id = element(aws_eip.changeme_spot_and_fargate_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.changeme_spot_and_fargate_subnet_public.*.id, count.index)
  depends_on    = [aws_internet_gateway.changeme_spot_and_fargate_internet_gateway]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "changeme_spot_and_fargate_eip" {
  count = length(var.changeme_spot_and_fargate_private_subnets)
  vpc   = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "changeme_spot_and_fargate_subnet_private" {
  vpc_id            = aws_vpc.changeme_spot_and_fargate_vpc.id
  cidr_block        = element(var.changeme_spot_and_fargate_private_subnets, count.index)
  availability_zone = element(var.changeme_spot_and_fargate_availability_zones, count.index)
  count             = length(var.changeme_spot_and_fargate_private_subnets)
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "changeme_spot_and_fargate_subnet_public" {
  vpc_id                  = aws_vpc.changeme_spot_and_fargate_vpc.id
  cidr_block              = element(var.changeme_spot_and_fargate_public_subnets, count.index)
  availability_zone       = element(var.changeme_spot_and_fargate_availability_zones, count.index)
  count                   = length(var.changeme_spot_and_fargate_public_subnets)
  map_public_ip_on_launch = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "changeme_spot_and_fargate_route_table_public" {
  vpc_id = aws_vpc.changeme_spot_and_fargate_vpc.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "changeme_spot_and_fargate_aws_route_public" {
  route_table_id         = aws_route_table.changeme_spot_and_fargate_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.changeme_spot_and_fargate_internet_gateway.id
  timeouts {
    create = "5m"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "changeme_spot_and_fargate_route_table_private" {
  count  = length(var.changeme_spot_and_fargate_private_subnets)
  vpc_id = aws_vpc.changeme_spot_and_fargate_vpc.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "changeme_spot_and_fargate_route_private" {
  count                  = length(compact(var.changeme_spot_and_fargate_private_subnets))
  route_table_id         = element(aws_route_table.changeme_spot_and_fargate_route_table_private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.changeme_spot_and_fargate_nat_gateway.*.id, count.index)
  timeouts {
    create = "5m"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "changeme_spot_and_fargate_route_table_association_private" {
  count          = length(var.changeme_spot_and_fargate_private_subnets)
  subnet_id      = element(aws_subnet.changeme_spot_and_fargate_subnet_private.*.id, count.index)
  route_table_id = element(aws_route_table.changeme_spot_and_fargate_route_table_private.*.id, count.index)
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "changeme_spot_and_fargate_route_table_association_public" {
  count          = length(var.changeme_spot_and_fargate_public_subnets)
  subnet_id      = element(aws_subnet.changeme_spot_and_fargate_subnet_public.*.id, count.index)
  route_table_id = aws_route_table.changeme_spot_and_fargate_route_table_public.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "changeme_spot_and_fargate_iam_role_cluster" {
  name                  = "${var.changeme_spot_and_fargate_name}-eks-cluster-role"
  force_detach_policies = true

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks.amazonaws.com",
          "eks-fargate-pods.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "changeme_spot_and_fargate_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.changeme_spot_and_fargate_iam_role_cluster.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "changeme_spot_and_fargate_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.changeme_spot_and_fargate_iam_role_cluster.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
resource "aws_eks_cluster" "changeme_spot_and_fargate_eks_cluster" {
  name     = "${var.changeme_spot_and_fargate_name}-${var.changeme_spot_and_fargate_environment}"
  role_arn = aws_iam_role.changeme_spot_and_fargate_iam_role_cluster.arn

  vpc_config {
    subnet_ids = concat(aws_subnet.changeme_spot_and_fargate_subnet_public.*.id, aws_subnet.changeme_spot_and_fargate_subnet_private.*.id)
  }

  timeouts {
    delete = "30m"
  }

  depends_on = [
    aws_iam_role_policy_attachment.changeme_spot_and_fargate_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.changeme_spot_and_fargate_AmazonEKSServicePolicy
  ]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
resource "aws_iam_openid_connect_provider" "changeme_iam_openid_connect_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.changeme_external_thumbprint_data.result.thumbprint]
  url             = data.aws_eks_cluster.changeme_spot_and_fargate_eks_cluster_data.identity[0].oidc[0].issuer

  lifecycle {
    ignore_changes = [thumbprint_list]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "changeme_spot_and_fargate_iam_role_node_group" {
  name                  = "${var.changeme_spot_and_fargate_name}-eks-node-group-role"
  force_detach_policies = true

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "changeme_spot_and_fargate_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.changeme_spot_and_fargate_iam_role_node_group.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "changeme_spot_and_fargate_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.changeme_spot_and_fargate_iam_role_node_group.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "changeme_spot_and_fargate_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.changeme_spot_and_fargate_iam_role_node_group.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
resource "aws_eks_node_group" "changeme_spot_and_fargate_eks_node_group" {
  cluster_name    = aws_eks_cluster.changeme_spot_and_fargate_eks_cluster.name
  node_group_name = "changeme-eks-cluster-kube-system"
  node_role_arn   = aws_iam_role.changeme_spot_and_fargate_iam_role_node_group.arn
  subnet_ids      = aws_subnet.changeme_spot_and_fargate_subnet_private.*.id
  capacity_type   = "SPOT"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t2.micro"]

  version = var.changeme_spot_and_fargate_k8s_version

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.changeme_spot_and_fargate_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.changeme_spot_and_fargate_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.changeme_spot_and_fargate_AmazonEC2ContainerRegistryReadOnly,
  ]
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "cluster_id" {
  description = "ID of the created cluster"
  value       = aws_eks_cluster.changeme_spot_and_fargate_eks_cluster.id
}

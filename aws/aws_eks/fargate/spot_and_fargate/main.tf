terraform {
  required_version = ">= 0.14.0"
}

provider "aws" {
  region = "us-east-1"
}

module "eks-spot-and-fargate-network" {
  source = "./network"
  name               = var.name
  environment        = var.environment
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}


module "eks-spot-and-fargate-cluster" {
  source          = "./eks_cluster"
  name            = var.name
  environment     = var.environment
  region          = var.region
  k8s_version     = var.k8s_version
  vpc_id          = module.eks-spot-and-fargate-network.id
  private_subnets = module.eks-spot-and-fargate-network.private_subnets
  public_subnets  = module.eks-spot-and-fargate-network.public_subnets
}
# Spot instances + fargate EKS cluster

This example sets the cluster control plane on SPOT instances (for test purposes, and saving credits) and normal workloads on Fargate (Pay per Pod). To make the control plane use normal instances you just need to comment the line with `capacity_type   = "SPOT"` main.tf.
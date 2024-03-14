#!/bin/bash

# Download and install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Verify kubectl version
kubectl version --client

# Install AWS CLI
sudo snap install aws-cli --classic

# Configure AWS CLI
echo "Configuring AWS CLI..."
read -p "AWS Access Key ID: " aws_access_key
read -p "AWS Secret Access Key: " aws_secret_key
read -p "Default region name: " aws_region

aws configure set aws_access_key_id $aws_access_key
aws configure set aws_secret_access_key $aws_secret_key
aws configure set default.region $aws_region
aws configure set default.output json

# Update kubeconfig for Amazon EKS
eks_cluster_name="pc-eks"
aws eks update-kubeconfig --region $aws_region --name $eks_cluster_name

echo "--Added new context arn:aws:eks:$aws_region:918023795654:cluster/$eks_cluster_name to $HOME/.kube/config"

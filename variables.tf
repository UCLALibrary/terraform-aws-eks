#####################
# AWS Settings
#####################
variable "aws_region" {
  description = "AWS region for deployment"
  type = string
  default = "us-west-2"
}

#####################
# Tags
#####################
variable "name" {
  description = "Name of application"
  type = string
  default = ""
}

variable "tags" {
  description = "Tag prefixed to all EKS resources"
  type = map(string)
  default = {}
}

#####################
# EKS
#####################
variable "node_min_size" {
  description = "Minimum amount of nodes to run in EKS Nodegroup"
  type = number
  default = 1
}

variable "k8s_version" {
  description = "Version of Kubernetes to run in EKS"
  type = number
  default = 1.17
}

variable "nodegroup_instance_types" {
  description = "EC2 instance types created to attach to EKS Nodegroup"
  type = list(string)
  default = ["t3.micro"]
}

variable "node_desired_size" {
  description = "Desired amount of nodes to run in EKS Nodegroup"
  type = number 
  default = 1
}

variable "node_max_size" {
  description = "Max amount of nodes to run in EKS Nodegroup"
  type = number
  default = 1
}

variable "cluster_subnet_ids" {
  description = "List of subnet id strings for EKS cluster"
  type = list(string)
  default = []
}

variable "cluster_role_arn" {
  description = "EKS Cluster IAM role ARN"
  type = string
  default = ""
}

variable "nodegroup_role_arn" {
  description = "EKS Nodegroup IAM role ARN"
  type = string
  default = ""
}

variable "nodegroup_subnet_ids" {
  description = "List of subnet id strings for EKS nodegroup"
  type = list(string)
  default = []
}

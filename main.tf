resource "aws_eks_cluster" "this" {
  name = var.name
  role_arn = var.cluster_role_arn
  version = var.k8s_version
  
  vpc_config {
    subnet_ids = var.eks_cluster_subnet_ids
  }

  tags = merge(
    {
      "Name" = format("%s", var.name),
    },
    var.tags
  )
}

data "external" "eks_oidc_thumbprint" {
  program = ["bash", "./helpers/oidc-thumbprint.sh", var.aws_region]
}

resource "aws_iam_openid_connect_provider" "eks_openid_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.eks_oidc_thumbprint.result.thumbprint]
  url             = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer

  tags = merge(
    {
      "Name" = format("%s", var.name),
    },
    var.tags
  )
}

resource "aws_eks_node_group" "this" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = var.name

  node_role_arn = var.nodegroup_role_arn
  subnet_ids = var.nodegroup_subnet_ids

  instance_types = var.nodegroup_instance_types

  scaling_config {
    desired_size = var.node_desired_size
    max_size = var.node_max_size
    min_size = var.node_min_size
  }

  tags = merge(
    {
      "Name" = format("%s", var.name),
    },
    var.tags
  )
}

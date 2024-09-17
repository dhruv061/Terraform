#Creating Nodegroup
resource "aws_eks_node_group" "node-grp" {
    cluster_name    = var.cluster_name
    node_group_name = var.node_group_name
    node_role_arn   = var.eks_node_grp_role_Arn
    subnet_ids      = var.subnet_ids
    capacity_type   = var.capacity_type
    disk_size       = var.disk_size
    instance_types  = var.instance_types
    
    scaling_config {
      desired_size = var.scaling_config.desired_size
      max_size     = var.scaling_config.max_size
      min_size     = var.scaling_config.min_size
    }

    update_config {
      max_unavailable = var.update_config.max_unavailable
    }

    tags = {
      "Name" = "Dhruv-EKS-NG"
    }

    depends_on = [var.ng_depends_on]
  }
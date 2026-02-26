module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.common_name_suffix
  kubernetes_version = var.eks_version

  # 🔹 ADD THIS
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # 🔹 ADD THIS (THIS FIXES YOUR ERROR)
  create_cloudwatch_log_group = false

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    metrics-server = {}
  }

  endpoint_public_access = false
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  create_node_security_group = false
  create_security_group      = false
  node_security_group_id     = local.eks_node_sg_id
  security_group_id          = local.eks_control_plane_sg_id

  eks_managed_node_groups = {
    blue = {
      create              = var.enable_blue
      ami_type            = "AL2023_x86_64_STANDARD"
      kubernetes_version  = var.eks_nodegroup_blue_version
      instance_types      = ["m5.xlarge"]

      min_size     = 2
      max_size     = 10
      desired_size = 2

      iam_role_additional_policies = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      labels = {
        nodegroup = "blue"
      }
    }

    green = {
      create              = var.enable_green
      ami_type            = "AL2023_x86_64_STANDARD"
      kubernetes_version  = var.eks_nodegroup_green_version
      instance_types      = ["m5.xlarge"]

      min_size     = 2
      max_size     = 10
      desired_size = 2

      iam_role_additional_policies = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      labels = {
        nodegroup = "green"
      }
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.common_name_suffix
    }
  )
}
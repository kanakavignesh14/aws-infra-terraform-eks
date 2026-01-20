data "aws_ssm_parameter" "ingress_alb-sg_id"  {
    name = "/${var.project_name}/${var.environment}/ingress_alb-sg_id"
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"  # we are sending name it will fetch value from ssm_parameter
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}


data "aws_ssm_parameter" "ingress_alb_certificate_arn" { # our certificate arn
  name  = "/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"
}

data "aws_ssm_parameter" "eks_control_plane-sg_id" { # our certificate arn
  name  = "/${var.project_name}/${var.environment}/eks_control_plane-sg_id"
}

data "aws_ssm_parameter" "eks_node-sg_id" { # our certificate arn
  name  = "/${var.project_name}/${var.environment}/eks_node-sg_id"
}



locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ingress-ALB-sg_id = data.aws_ssm_parameter.ingress_alb-sg_id.value
  public_subnet_ids = split("," , data.aws_ssm_parameter.public_subnet_ids.value)  # ["10.0.11.0/24","10.0.12.0/24"] giving two subnets
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
  ingress_alb_certificate_arn = data.aws_ssm_parameter.ingress_alb_certificate_arn.value
}
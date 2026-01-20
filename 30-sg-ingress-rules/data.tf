

data "aws_ssm_parameter" "bastion-sg_id"  {
    name = "/${var.project_name}/${var.environment}/bastion-sg_id"
}

data "aws_ssm_parameter" "mongodb-sg_id" {
    name = "/${var.project_name}/${var.environment}/mongodb-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "redis-sg_id" {
    name = "/${var.project_name}/${var.environment}/redis-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "rabbitmq-sg_id" {
    name = "/${var.project_name}/${var.environment}/rabbitmq-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "mysql-sg_id" {
    name = "/${var.project_name}/${var.environment}/mysql-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}






data "aws_ssm_parameter" "ingress_alb-sg_id" {
    name = "/${var.project_name}/${var.environment}/ingress_alb-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "open_vpn-sg_id" {
    name = "/${var.project_name}/${var.environment}/open_vpn-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "eks_control_plane-sg_id" {
    name = "/${var.project_name}/${var.environment}/eks_control_plane-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "eks_node-sg_id" {
    name = "/${var.project_name}/${var.environment}/eks_node-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}
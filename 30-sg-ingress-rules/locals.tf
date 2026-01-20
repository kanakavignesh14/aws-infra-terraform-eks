locals {
  #vpc_id             = data.aws_ssm_parameter.vpc-id.value
  bastion-sg_id = data.aws_ssm_parameter.bastion-sg_id.value
  mongodb-sg_id = data.aws_ssm_parameter.mongodb-sg_id.value
  redis-sg_id = data.aws_ssm_parameter.redis-sg_id.value
  mysql-sg_id = data.aws_ssm_parameter.mysql-sg_id.value
  rabbitmq-sg_id = data.aws_ssm_parameter.rabbitmq-sg_id.value

  ingress-lb-sg_id = data.aws_ssm_parameter.ingress_alb-sg_id.value
  eks_control_plane-sg_id = data.aws_ssm_parameter.eks_control_plane-sg_id.value
  eks_node-sg_id = data.aws_ssm_parameter.eks_node-sg_id.value



  vpn_ingress_rules = {
        mysql_22 = {
            sg_id = local.mysql-sg_id
            port = 22
        }
        mysql_3306 = {
            sg_id = local.mysql-sg_id
            port = 3306
        }
        redis = {
            sg_id = local.redis-sg_id
            port = 22
        }
        mongodb = {
            sg_id = local.mongodb-sg_id
            port = 22
        }
        rabbitmq = {
            sg_id = local.rabbitmq-sg_id
            port = 22
        }
        # catalogue = {
        #     sg_id = local.catalogue_sg_id
        #     port = 22
        # }
        # catalogue_8080 = {
        #     sg_id = local.catalogue_sg_id
        #     port = 8080
        # }
        # user = {
        #     sg_id = local.user_sg_id
        #     port = 22
        # }
        # cart = {
        #     sg_id = local.cart_sg_id
        #     port = 22
        # }
        # shipping = {
        #     sg_id = local.shipping_sg_id
        #     port = 22
        # }
        # payment = {
        #     sg_id = local.payment_sg_id
        #     port = 22
        # }
        # frontend = {
        #     sg_id = local.frontend_sg_id
        #     port = 22
        # }
        # backend_alb = {
        #     sg_id = local.backend_alb_sg_id
        #     port = 80
        # }
    }
}



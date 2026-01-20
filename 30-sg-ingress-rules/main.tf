## Laptop(internet) to Bastion sg rule
resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.bastion-sg_id
}

## Bastion to frontend sg rule


## Bastion to mongodb sg rule
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mongodb-sg_id
  source_security_group_id = local.bastion-sg_id  
}

## Bastion to redis sg rule
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.redis-sg_id
  source_security_group_id = local.bastion-sg_id  
}

## Bastion to mysql sg rule
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mysql-sg_id
  source_security_group_id = local.bastion-sg_id  
}

## Bastion to catalogue sg rule


## Bastion to user sg rule

## Bastion to cart sg rule


## Bastion to shipping sg rule


## Bastion to payment sg rule



## Bastion to rabbitmq sg rule
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.rabbitmq-sg_id
  source_security_group_id = local.bastion-sg_id  
}

## Bastion to backend-alb sg rule


## backend-alb to catalogue sg rule


## backend-alb to user sg rule


## backend-alb to cart sg rule


## backend-alb to shipping sg rule



## backend-alb to payment sg rule



## payment to rabbitmq sg rule


## catalogue to mongodb sg rule


## user to mongodb sg rule


## user to redis sg rule


## cart to backend-alb(for catalogue) sg rule


## shipping to backend-alb(for cart) sg rule


## shipping to mysql sg rule


## payment to backend-alb(for cart, user) sg rule


## frontend-alb to frontend sg rule


## Internet to frontend-alb sg rule
resource "aws_security_group_rule" "ingress-lb_internet" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = local.ingress-lb-sg_id
  cidr_blocks       = ["0.0.0.0/0"]  
}

## frontend to backend-alb sg rule

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  security_group_id = local.eks_control_plane-sg_id
  source_security_group_id = local.bastion-sg_id
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "eks_node_bastion" {
  type              = "ingress"
  security_group_id = local.eks_node-sg_id
  source_security_group_id = local.bastion-sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

# EKS nodes can accept all kind of traffic from EKS control plane

resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  security_group_id = local.eks_node-sg_id
  source_security_group_id = local.eks_control_plane-sg_id
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}
# EKS cluster can accept traffic from all nodes
resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type              = "ingress"
  security_group_id = local.eks_control_plane-sg_id
  source_security_group_id = local.eks_node-sg_id
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}

# Mandatory for pod to pod communication. because pods can be in any node in VPC CIDR
resource "aws_security_group_rule" "eks_node_vpc" {
  type              = "ingress"
  security_group_id = local.eks_node-sg_id
  cidr_blocks = ["10.0.0.0/16"]
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}

#This allows:

#Any pod on any node

#To talk to any pod on any node

#Using any protocol/port

#This is mandatory baseline networking for Kubernetes.
#internal-roboshop-dev-backend-alb-546249150.us-east-1.elb.amazonaws.com.
#internal-roboshop-dev-backend-ALB-546249150.us-east-1.elb.amazonaws.com
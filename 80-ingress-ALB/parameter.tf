
# why we are sending lb's arn is to at services (catalogue) will conffigure listner rule using this arn
resource "aws_ssm_parameter" "ingress_alb_listener_arn" {
    name = "/${var.project_name}/${var.environment}/ingress_alb_listener-arn"
    type = "String"
    value = aws_lb_listener.ingress_alb_listener.arn
}

# to Configure listener rule we r using this listner arn
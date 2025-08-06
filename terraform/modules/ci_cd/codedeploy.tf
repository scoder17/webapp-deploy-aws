# resource "aws_codedeploy_app" "app" {
#   name             = "webapp"
#   compute_platform = "Server"
# }

# resource "aws_codedeploy_deployment_group" "webapp_group" {
#   app_name              = aws_codedeploy_app.app.name
#   deployment_group_name = "webapp-deployment-group"
#   service_role_arn      = aws_iam_role.codedeploy_role.arn

#   deployment_style {
#     deployment_type   = "IN_PLACE"
#     deployment_option = "WITHOUT_TRAFFIC_CONTROL"
#   }

#   ec2_tag_set {
#     ec2_tag_filter {
#       key   = "Name"
#       type  = "KEY_AND_VALUE"
#       value = "app-instance"
#     }
#   }

#   load_balancer_info {
#     target_group_info {
#       name = var.lb_target_group_name
#     }
#   }

#   auto_rollback_configuration {
#     enabled = true
#     events  = ["DEPLOYMENT_FAILURE"]
#   }
# }

resource "aws_codedeploy_app" "app" {
  name             = "webapp"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "webapp_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "webapp-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "app-instance"
    }
  }

  autoscaling_groups = [
    var.blue_asg_name,
    var.green_asg_name
  ]

  load_balancer_info {
    target_group_info {
      name = var.lb_target_group_name
    }
    target_group_pair_info {
      target_group {
        name = var.lb_target_group_name
      }

      prod_traffic_route {
        listener_arns = [var.listener_arn]
      }

      test_traffic_route {
        listener_arns = [var.listener_arn]
      }
    }
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }

    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }

    green_fleet_provisioning_option {
      action = "DISCOVER_EXISTING"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
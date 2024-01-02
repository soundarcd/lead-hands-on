module "vpc_application" {
  source = "./modules/network"

  vpc_name                    = var.vpc_name
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_block    = var.public_subnet_cidr_block
  public_subnet_cidr_block_2  = var.public_subnet_cidr_block_2
  private_subnet_cidr_block   = var.private_subnet_cidr_block
  private_subnet_cidr_block_2 = var.private_subnet_cidr_block_2
  availability_zone           = var.availability_zone # Update with your preferred availability zone
  availability_zone_2         = var.availability_zone_2
}


######Security group for application load balancer####

module "alb_sg_frontend" {
  source              = "./modules/securitygroup"
  security_group_name = var.frontend_alb_security_group_name
  vpc_id              = module.vpc_application.vpc_id # Replace Iwith your VPC ID
}

module "alb_sg_backened" {
  source              = "./modules/securitygroup"
  security_group_name = var.backened_alb_security_group_name
  vpc_id              = module.vpc_application.vpc_id # Replace Iwith your VPC ID
}

module "sg_autoscaling" {
  source              = "./modules/securitygroup"
  security_group_name = var.autoscaling_security_group_name
  vpc_id              = module.vpc_application.vpc_id # Replace Iwith your VPC ID
}


############# Application loadbalancer and Autoscaling group with the failover instances####


module "frontendalb" {
  source                       = "./modules/alb"
  alb_name                     = var.frontend_alb_name
  internal                     = false
  instance_security_group_name = var.frontend_instance_security_group_name
  security_groups              = [module.alb_sg_frontend.security_group_id]                                           // Replace with your security group IDs
  subnets                      = [module.vpc_application.public_subnet_id, module.vpc_application.public_subnet_id_2] // Replace with your subnet IDs
  enable_deletion_protection   = false
  #subnet                = module.vpc_application.private_subnet_id 
  vpc_id               = module.vpc_application.vpc_id
  targetgroup          = var.frontend_targetgroup
  vpc_zone_identifier  = [module.vpc_application.public_subnet_id, module.vpc_application.public_subnet_id_2]
  autoscalinggroupname = var.frontend_autoscalinggroupname
  image_id             = var.frontend_image_id
  instance_type        = var.frontend_instance_type
  key_name             = var.frontend_key_name
  min_size             = var.frontend_min_size
  max_size             = var.frontend_max_size
  desired_capacity     = var.frontend_desired_capacity

  user_data            = var.frontend_user_data
}


module "backenedalb" {
  source                       = "./modules/alb"
  alb_name                     = var.backened_alb_name
  internal                     = false
  instance_security_group_name = var.backened_instance_security_group_name
  security_groups              = [module.alb_sg_backened.security_group_id]                                           // Replace with your security group IDs
  subnets                      = [module.vpc_application.public_subnet_id, module.vpc_application.public_subnet_id_2] // Replace with your subnet IDs
  enable_deletion_protection   = false
  ##  subnet                = module.vpc_application.private_subnet_id
  vpc_id               = module.vpc_application.vpc_id
  targetgroup          = var.backened_targetgroup
  vpc_zone_identifier  = [module.vpc_application.private_subnet_id, module.vpc_application.private_subnet_id_2]
  autoscalinggroupname = var.backened_autoscalinggroupname
  image_id             = var.backened_image_id
  instance_type        = var.backened_instance_type
  key_name             = var.backened_key_name
  min_size             = var.backened_min_size
  max_size             = var.backened_max_size
  desired_capacity     = var.backened_desired_capacity
  user_data            = var.backened_user_data

}

####Not tested #######

 Create Auto Scaling Group
resource "aws_autoscaling_group" "example_asg" {
  launch_configuration = aws_launch_configuration.example_launch_config.name
  min_size              = 1
  max_size              = 3
  desired_capacity      = 2
  # Add other ASG configuration parameters as needed

  # Add CloudWatch Alarms for ASG metrics
  metric_alarm {
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    metric_name         = "GroupTotalInstances"
    namespace           = "AWS/AutoScaling"
    period              = "300"
    statistic           = "Average"
    threshold           = "2"
    alarm_description   = "Alarm when ASG instances are greater than or equal to 2"
    alarm_actions       = [aws_sns_topic.example_topic.arn]
  }
}

# Create SNS Topic for email notifications
resource "aws_sns_topic" "example_topic" {
  name = "ASGEmailNotifications"
}

# Create SNS Topic Subscription for email notifications
resource "aws_sns_topic_subscription" "example_subscription" {
  topic_arn = aws_sns_topic.example_topic.arn
  protocol  = "email"
  endpoint  = "devops@clouddestinations.com"  # Replace with your email address
}

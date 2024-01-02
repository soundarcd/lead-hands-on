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

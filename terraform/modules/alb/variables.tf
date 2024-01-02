variable "alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
}

variable "internal" {
  description = "Specify if the ALB should be internal"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "List of security groups for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets for the ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "targetgroup" {
  description = "name"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to be launched"
  type        = number
  default     = 2
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in."
  type        = list(string)
}


variable "autoscalinggroupname" {
  description = "Name of the autoscaling group"
  type        = string
}

variable "user_data" {
  description = "user data"
  type        = string
}


variable "instance_security_group_name" {
  description = "instance_security_group_name"
  type        = string
}


#variable "subnet" {
#  description = "instance_security_group_name"
#  type        = string
#}

variable "image_id" {
  description = "image id for triggering the instances"
  type    = string
}

variable "instance_type" {
  description = "type of the instances"
  type    = string
}

variable "key_name" {
  description = "keyname for the instances"
  type  = string
}

variable "min_size" {
  description = "minimal number of instance" 
  type = string
}

variable "max_size" {
  description = "maximum number of servers" 
  type = string
}

variable "desired_capacity"  {
  description = "desired capacity"
  type = string
}


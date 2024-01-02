# ec2-instance-module/variables.tf

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones for the EC2 instances"
  type        = list(string)
}


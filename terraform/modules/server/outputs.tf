# ec2-instance-module/outputs.tf

output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_autoscaling_group.example_asg.instance_ids
}


# outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "public_subnet_id_2" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet_2.id
}
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "private_subnet_id_2" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet_2.id
}

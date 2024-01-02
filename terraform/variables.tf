variable "frontend_alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
  default     = "frontend-alb"
}

variable "backened_alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
  default     = "backened-alb"
}

variable "internal" {
  description = "Specify if the ALB should be internal"
  type        = bool
  default     = false
}

variable "frontend_instance_security_group_name" {
  description = "Specify the name of the security group"
  type         = string
  default      = "frontend-instance-sg"
}

variable "backened_instance_security_group_name" {
  description = "Specify the name of the security group"
  type         = string
  default      = "backened-instance-sg"
}


variable "frontend_alb_security_group_name" {
  description = "Specify the name of the security group"
  type         = string
  default      = "frontend-alb-sg"
}

variable "backened_alb_security_group_name" {
  description = "Specify the name of the security group"
  type         = string
  default      = "backened-alb-sg"
}

variable "autoscaling_security_group_name" {
  description = "Specify the name of the security group"
  type         = string
  default      = "autoscaling-sg"
}


##########



variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}


variable "public_subnet_cidr_block" {
  description = "public subnet name"
  type        = string
  default    = "10.0.1.0/24"
}

variable "public_subnet_cidr_block_2" {
  description = "vpc name"
  type        = string
  default    = "10.0.2.0/24"
}

variable "private_subnet_cidr_block" {
  description = "vpc name"
  type        = string
  default    = "10.0.3.0/24"
}

variable "private_subnet_cidr_block_2" {
  description = "vpc name"
  type        = string
  default    = "10.0.4.0/24"
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
  default    = "us-west-1a"
}

variable "availability_zone_2" {
  description = "availability zone"
  type        = string
  default    = "us-west-1c"
}

variable "vpc_cidr_block" {
  description = "vpc name"
  type        = string
  default    = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default    = "clouddestiny_vpc"
}

####################


variable "backened_targetgroup" {
  description = "name"
  type        = string
  default     = "backened-target-group"
}


variable "frontend_targetgroup" {
  description = "name"
  type        = string
  default     = "frontend-target-group"
}




variable "backened_autoscalinggroupname" {
  description = "Name of the autoscaling group"
  type        = string
  default     = "backened_autscaling_group"
}



variable "frontend_autoscalinggroupname" {
  description = "Name of the autoscaling group"
  type        = string
  default     = "frontend_autscaling_group"
}



variable "frontend_image_id" {
  description = "image id for triggering the instances"
  type        = string
  default     = "ami-0ce2cb35386fc22e9"
}


variable "backened_image_id" {
  description = "image id for triggering the instances"
  type        = string
  default     = "ami-0ce2cb35386fc22e9"
}

variable "frontend_instance_type" {
  description = "type of the instances"
  type        = string
  default     = "t2.micro"
}

variable "backened_instance_type" {
  description = "type of the instances"
  type        = string
  default     = "t2.micro"
}


variable "frontend_key_name" {
  description = "keyname for the instances"
  type        = string
  default     = "cloudtest.pem"
}

variable "backened_key_name" {
  description = "keyname for the instances"
  type        = string
  default     = "cloudtest.pem"
}

variable "frontend_min_size" {
  description = "minimal number of instance"
  type        = string
  default     = "2"
}

variable "backened_min_size" {
  description = "minimal number of instance"
  type        = string
  default     = "2"
}


variable "frontend_max_size" {
  description = "maximum number of servers"
  type        = string
  default     = "2"
}


variable "backened_max_size" {
  description = "maximum number of servers"
  type        = string
  default     = "2"
}



variable "frontend_desired_capacity" {
  description = "desired capacity"
  type        = string
  default     = "2"
}


variable "backened_desired_capacity" {
  description = "desired capacity"
  type        = string
  default     = "2"
}






######### Frontend user data #########


variable "frontend_user_data" {
  description = "user data"
  type        = string
  default     = <<-EOF
              #!/bin/bash
              
              # Update package list
              sudo apt update -y

              # Install Node.js and npm
              sudo apt install -y nodejs npm

              # Verify Node.js and npm installation
              node -v
              npm -v

              # Install pm2 globally
              sudo npm install pm2 -g

              echo "pm2 install complete" >> /tmp/pm2.txt

              curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

             echo "downloadcomplete complete" >> /tmp/download.txt
             source ~/.bashrc

              nvm install 18


              nvm use v18

              yes | npx create-react-app my-react-app

              # Create a React app
              #npx create-react-app my-react-app

              # Start the React app using pm2

              pm2 start npm --name "ping-frontend" -- start

              EOF

}


######## Backened user data #########


variable "backened_user_data" {
  description = "user data"
  type        = string
  default     = <<-EOF
              #!/bin/bash

              # Update package list
              sudo apt update -y

              # Install Node.js and npm
              sudo apt install -y nodejs npm

              # Verify Node.js and npm installation
              node -v
              npm -v

              # Install pm2 globally
              sudo npm install pm2 -g

              echo "pm2 install complete" >> /tmp/pm2.txt

              curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

             echo "downloadcomplete complete" >> /tmp/download.txt
             source ~/.bashrc

              nvm install 18


              nvm use v18


              # Create node app

              pm2 start npm --name "ping-backened" -- start

              EOF


}

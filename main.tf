terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "Beanstalk_web_server" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  
  tags = {Name = "Beanstalk Server"}


  }

 resource "aws_security_group" "allow_http" { 
    name        = "allow_http"  
    description = "Allow inbound HTTP traffic"  
    ingress {    
     description = "HTTP from anywhere"   
     from_port   = 80    
     to_port     = 80    
     protocol    = "tcp"    
     cidr_blocks = ["0.0.0.0/0"] 

     
     }
     tags = {Name = "Beanstalk_sg"}
     }
output "instance_id" {
  value = aws_instance.Beanstalk_web_server.id
}
output "private_ip"{
  value = aws_instance.Beanstalk_web_server.private_ip
  
}
output "instance_name" {
  value = aws_instance.Beanstalk_web_server.tags["Name"]
}
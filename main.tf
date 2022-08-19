terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-3"
}

resource "aws_instance" "app_server" {
  ami           = "ami-02d0b1ffa5f16402d"
  instance_type = "t2.micro"
  subnet_id = "subnet-02b3ceae20b7230c7"	

  tags = {
    Name = "ExampleAppServerInstance"
  }
}


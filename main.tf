terraform {
  cloud {
    organization = "Hashi-sami"
    workspaces {
      name = "My-existing-infra"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
  } 

  terraform {
  required_providers {
    tfe = {
      version = "~> 0.35.0"
    }
  }
}

provider "tfe" {
 hostname = var.hostname
 token    = var.token
}


provider "aws" {
  region  = "eu-west-3"
}

data "tls_certificate" "tfc_certificate" {
  url = "https://app.terraform.io"
}

resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["${data.tls_certificate.tfc_certificate.certificates.0.sha1_fingerprint}"]
}

resource "aws_instance" "app_server"{
  ami           = "ami-02d0b1ffa5f16402d"
  instance_type = "t2.micro"
  subnet_id     = "subnet-02b3ceae20b7230c7"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Create a workspace
resource "" "" {
  # ...
}

resource "tfe_team" "test" {
  name         = "owners"
  organization = "Hashi-sami"
}

resource "tfe_team_access" "test" {
  access       = "admin"  
  team_id      = tfe_team.test.id
  workspace_id = tfe_workspace.test.id
}

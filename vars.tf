variable "aws_region" {
  default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "aws_key_2"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "aws_key_2.pub"
}

variable "amis" {
  type = map(string)
  default = {
    eu-west-1 = "ami-01720b5f421cf0179"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "VPC_MAIN_ID" {
  default = "vpc-04728a62510ab1ea8"
}

variable "SUBNET_ID_A" {
  default = "subnet-016f275f6354fa569"
}

variable "SUBNET_ID_B" {
  default = "subnet-09c7550a60a37fc44"
}
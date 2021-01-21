variable "aws_region" {
  default = "eu-west-1"
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

variable "vpc_main" {
  default = "vpc-04728a62510ab1ea8"
}

variable "subnet_a" {
  default = "subnet-016f275f6354fa569"
}

variable "subnet_b" {
  default = "subnet-09c7550a60a37fc44"
}

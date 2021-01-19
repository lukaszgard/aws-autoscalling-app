terraform {
  backend "s3" {
    bucket = "lgardon-terraform-remote-state"
    key    = "autoscalling-01"
    region = "eu-west-1"
  }
}

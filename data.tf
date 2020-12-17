# Declare the data source
data "aws_availability_zones" "AZs" {
  state = "available"
}

#Red Hat Enterprise Linux 8#############
data "aws_ami" "app_server" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["Red Hat Enterprise Linux 8 *"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

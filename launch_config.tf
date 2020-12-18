resource "aws_launch_configuration" "app_server" {
  name              = "App-Server"
  image_id          = data.aws_ami.app_server.id
  instance_type     = "t2.micro"
  key_name          = "demo"
  security_groups   = [aws_security_group.app_server_sg.id]
  placement_tenancy = "default"
  #user_data         = file(apache.sh)
}

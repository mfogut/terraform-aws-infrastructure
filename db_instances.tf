resource "aws_db_instance" "db_instances" {
  count                  = length(slice(local.az_names, 0, local.end_index_db_subnet))
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = local.db_username
  password               = local.db_password
  parameter_group_name   = "db_instances.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]

  tags = {
    Name = "DB-Instance-${count.index + 1}"
  }
}


#Subnet Group allocated for DB Instances
resource "aws_db_subnet_group" "db_subnets" {
  name       = "db_subnet_group"
  subnet_ids = local.db_subnets_id

  tags = {
    Name = "Terraform-DB-Subnet-Group"
  }
}

output "Subnet_Group_IDs" {
  value       = aws_db_subnet_group.db_subnets.subnet_ids
  description = "Subnet Group IDs for DB instances."
}

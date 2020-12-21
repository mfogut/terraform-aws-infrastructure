locals {
  az_names = data.aws_availability_zones.AZs.names
}

locals {
  public_subnets_id = aws_subnet.public_subnet.*.id
}

locals {
  private_subnets_id = aws_subnet.private_subnet.*.id
}

locals {
  db_subnets_id = aws_subnet.db_subnet.*.id
}

locals {
  end_index_public_subnet = 2
}

locals {
  end_index_private_subnet = 2
}

locals {
  end_index_db_subnet = 2
}

locals {
  db_username = "fatih"
}

locals {
  db_password = "fatih123"
}

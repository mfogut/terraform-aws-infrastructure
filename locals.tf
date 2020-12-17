locals {
  az_names = data.aws_availability_zones.AZs.names
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

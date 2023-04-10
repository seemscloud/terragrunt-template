remote_state {
  backend = "local"

  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/vpc"
}

locals {
  tags = {
    Name    = "lorem-vpc"
    Project = "LoremIpsum"
  }
}

inputs = {
  cidr_block           = "10.255.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

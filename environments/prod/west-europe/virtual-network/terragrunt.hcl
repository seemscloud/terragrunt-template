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
  source = "${get_parent_terragrunt_dir()}/../../..//modules/virtual-network"
}

dependency "rg" {
  config_path = "../resource-group"

  mock_outputs = {
    resource_group_name = "resource_group_name"
  }
}

inputs = {
  virtual_network_name = "vnet-test"
  address_space        = ["10.0.0.0/16"]
  resource_group_name  = dependency.rg.outputs.resource_group_name
}
// Always generate subnet information for maximum supported AZs so we don't
// have to destructively rearrange them later.

data "null_data_source" "private_start" {
  inputs {
    index = "${ceil(4 / pow(2, var.private_subnet_bits - var.utility_subnet_bits))}"
  }
}

data "template_file" "subnet_yaml_a" {
  count = "${length(var.cluster_names)}"
  template = "${file("${path.module}/resources/subnet.yaml")}"

  vars {
    utility_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.utility_subnet_bits, 0)}"
    private_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.private_subnet_bits, 0 + data.null_data_source.private_start.outputs["index"])}"
    egress = "${var.nat_gateway_ids[0]}"
    zone = "${var.availability_zones[0]}"
  }
}

data "template_file" "subnet_yaml_b" {
  count = "${length(var.cluster_names)}"
  template = "${file("${path.module}/resources/subnet.yaml")}"

  vars {
    utility_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.utility_subnet_bits, 1)}"
    private_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.private_subnet_bits, 1 + data.null_data_source.private_start.outputs["index"])}"
    egress = "${var.nat_gateway_ids[1]}"
    zone = "${var.availability_zones[1]}"
  }
}

data "template_file" "subnet_yaml_c" {
  count = "${length(var.cluster_names)}"
  template = "${file("${path.module}/resources/subnet.yaml")}"

  vars {
    utility_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.utility_subnet_bits, 2)}"
    private_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.private_subnet_bits, 2 + data.null_data_source.private_start.outputs["index"])}"
    egress = "${var.nat_gateway_ids[2]}"
    zone = "${var.availability_zones[2]}"
  }
}

data "template_file" "subnet_yaml_d" {
  count = "${length(var.cluster_names)}"
  template = "${file("${path.module}/resources/subnet.yaml")}"

  vars {
    utility_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.utility_subnet_bits, 3)}"
    private_cidr = "${cidrsubnet(element(var.cluster_subnets, count.index), var.cluster_subnet_bits - var.private_subnet_bits, 3 + data.null_data_source.private_start.outputs["index"])}"
    egress = "${var.nat_gateway_ids[3]}"
    zone = "${var.availability_zones[3]}"
  }
}
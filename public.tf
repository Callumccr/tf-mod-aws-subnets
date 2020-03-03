locals {
  public_subnet_count = var.max_subnet_count == 0 ? length(data.aws_availability_zones.available.names) : var.max_subnet_count
}

resource "aws_subnet" "public" {
  count             = var.enabled ? length(var.availability_zones) : 0
  vpc_id            = data.aws_vpc.default.id
  availability_zone = element(var.availability_zones, count.index)

  cidr_block = cidrsubnet(
    signum(length(var.cidr_block)) == 1 ? var.cidr_block : data.aws_vpc.default.cidr_block,
    ceil(log(local.public_subnet_count * 2, 2)),
    local.public_subnet_count + count.index
  )

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    module.label.tags,
    var.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.public_subnet_label.id,
        var.delimiter,
        replace(
          element(var.availability_zones, count.index),
          "-",
          var.delimiter
        )
      )
    }
  )

  lifecycle {
    ignore_changes = [tags]
  }

}

resource "aws_route_table" "public" {
  count  = var.enabled ? length(var.availability_zones) : 0
  vpc_id = data.aws_vpc.default.id

  tags = merge(
    module.label.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.public_rt_label.id,
        var.delimiter,
        replace(
          element(var.availability_zones, count.index),
          "-",
          var.delimiter
        )
      )
    }
  )
}

resource "aws_route" "public" {
  count                  = signum(length(var.vpc_default_route_table_id)) == 1 ? 0 : length(var.availability_zones)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "public" {
  count          = signum(length(var.vpc_default_route_table_id)) == 1 ? 0 : length(var.availability_zones)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table_association" "public_default" {
  count          = signum(length(var.vpc_default_route_table_id)) == 1 ? length(var.availability_zones) : 0
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = var.vpc_default_route_table_id
}

resource "aws_network_acl" "public" {
  count      = signum(length(var.public_network_acl_id)) == 0 ? 1 : 0
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.public.*.id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = module.public_acl_label.tags
}

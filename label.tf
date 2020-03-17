module "label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = [""]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "private_subnet_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["private", "subnet"]))

  tags = merge(
    module.label.tags,
    map(var.subnet_type_tag_key, format(var.subnet_type_tag_value_format, "private"))
  )
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "private_acl_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["private", "acl"]))

  tags = merge(module.label.tags, {
    "Name" = module.private_acl_label.id
  })
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "public_subnet_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["public", "subnet"]))

  tags = merge(
    module.label.tags,
    map(var.subnet_type_tag_key, format(var.subnet_type_tag_value_format, "private"))
  )
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "public_acl_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["public", "acl"]))

  tags = merge(module.label.tags, {
    "Name" = module.public_acl_label.id
  })
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}


module "public_rt_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["public", "rt"]))

  tags = merge(
    module.label.tags,
    map(var.subnet_type_tag_key, format(var.subnet_type_tag_value_format, "private"))
  )
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "private_rt_label" {
  source     = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context    = module.label.context
  attributes = compact(concat(module.label.attributes, ["private", "rt"]))

  tags = merge(
    module.label.tags,
    map(var.subnet_type_tag_key, format(var.subnet_type_tag_value_format, "private"))
  )
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "private_nat_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context            = module.label.context
  attributes         = compact(concat(module.label.attributes, ["nat"]))
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

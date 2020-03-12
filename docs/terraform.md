## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cidr\_block | Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`) | `string` | n/a | yes |
| igw\_id | Internet Gateway ID the public route table will point to (e.g. `igw-9c26a123`) | `string` | n/a | yes |
| vpc\_id | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | n/a | yes |
| attributes | (Optional) - Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| aws\_account\_id | The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | (Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_assume\_role\_external\_id | (Optional) - The external ID to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_assume\_role\_session\_name | (Optional) - The session name to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_region | The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| delimiter | (Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| enabled | (Optional). A Switch that decides whether to create a terraform resource or run a provisioner. Default is true | `bool` | `true` | no |
| environment | (Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod' | `string` | `""` | no |
| map\_public\_ip\_on\_launch | Instances launched into a public subnet should be assigned a public IP address | `bool` | `true` | no |
| max\_subnet\_count | Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region | `number` | `0` | no |
| name | (Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline' | `string` | `""` | no |
| namespace | (Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core' | `string` | `""` | no |
| nat\_gateway\_enabled | Flag to enable/disable NAT Gateways to allow servers in the private subnets to access the Internet | `bool` | `true` | no |
| nat\_instance\_enabled | Flag to enable/disable NAT Instances to allow servers in the private subnets to access the Internet | `bool` | `false` | no |
| nat\_instance\_type | NAT Instance type | `string` | `"t3.micro"` | no |
| private\_network\_acl\_id | Network ACL ID that will be added to private subnets. If empty, a new ACL will be created | `string` | `""` | no |
| public\_network\_acl\_id | Network ACL ID that will be added to public subnets. If empty, a new ACL will be created | `string` | `""` | no |
| subnet\_type\_tag\_key | Key for subnet type tag to provide information about the type of subnets, e.g. `cpco.io/subnet/type=private` or `cpco.io/subnet/type=public` | `string` | `"cpco.io/subnet/type"` | no |
| subnet\_type\_tag\_value\_format | This is using the format interpolation symbols to allow the value of the subnet\_type\_tag\_key to be modified. | `string` | `"%s"` | no |
| tags | (Optional) - Additional tags | `map(string)` | `{}` | no |
| vpc\_default\_route\_table\_id | Default route table for public subnets. If not set, will be created. (e.g. `rtb-f4f0ce12`) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_zones | List of Availability Zones where subnets were created |
| nat\_gateway\_ids | IDs of the NAT Gateways created |
| private\_route\_table\_ids | IDs of the created private route tables |
| private\_subnet\_cidrs | CIDR blocks of the created private subnets |
| private\_subnet\_ids | IDs of the created private subnets |
| public\_route\_table\_ids | IDs of the created public route tables |
| public\_subnet\_cidrs | CIDR blocks of the created public subnets |
| public\_subnet\_ids | IDs of the created public subnets |


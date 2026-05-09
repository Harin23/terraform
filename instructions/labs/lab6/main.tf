data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_vpc" "production" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
 tags = {
    Name        = "${local.name_prefix}vpc-${data.aws_region.current.region}"  # <-- update value here
    Environment = local.tags.Environment  # <-- update value here
    Project     = local.tags.Project  # <-- update value here
    Owner       = local.tags.Owner  # <-- update value here
    CostCenter  = local.tags.CostCenter  # <-- update value here
    Region      = local.tags.Region  # <-- update value here
    ManagedBy   = local.tags.ManagedBy  # <-- update value here
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.production.id
  cidr_block              = var.subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-private-subnet"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
    Region      = data.aws_region.current.name
    AZ          = data.aws_availability_zones.available.names[0]
  }
}

resource "aws_route_table" "static" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name        = "${var.environment}-route-table"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
    Region      = data.aws_region.current.name
  }
}
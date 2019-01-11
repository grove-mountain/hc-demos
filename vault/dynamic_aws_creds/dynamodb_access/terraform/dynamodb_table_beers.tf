variable "dynamodb_name" {
  type    = "string"
  default = "beers"
}

variable "environment" {
  type    = "string"
  default = "prod"
}

variable "owner" {
  type        = "string"
  default     = "DELETEME"
  description = "The person who launched or ultimately pays for this resource"
}

variable "ttl" {
  type        = "string"
  default     = "1"
  description = "The time in hours for this entire workspace to live"
}

locals {
  db_name = "${var.owner}-vault-demo-beers"
}

resource "aws_dynamodb_table" "beers" {
  name           = "${local.db_name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Brewery"
  range_key      = "Beer"

  attribute {
    name = "Brewery"
    type = "S"
  }

  attribute {
    name = "Beer"
    type = "S"
  }

  tags = {
    Name        = "${local.db_name}"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
    TTL         = "${var.ttl}"
  }
}

resource "aws_dynamodb_table_item" "anchor_cali_lager" {
  table_name = "${aws_dynamodb_table.beers.name}"
  hash_key   = "${aws_dynamodb_table.beers.hash_key}"
  range_key   = "${aws_dynamodb_table.beers.range_key}"

  item = <<ITEM
  {
  "Brewery": {"S": "Anchor"},
  "Beer": {"S": "California Lager"},
  "Style": {"S": "Lager"},
  "SRM": {"N": "6"},
  "IBU": {"N": "20"},
  "ABV": {"N": "4.9"}
  }
  ITEM
}

resource "aws_dynamodb_table_item" "anchor_steam" {
  table_name = "${aws_dynamodb_table.beers.name}"
  hash_key   = "${aws_dynamodb_table.beers.hash_key}"
  range_key   = "${aws_dynamodb_table.beers.range_key}"

  item = <<ITEM
  {
  "Brewery": {"S": "Anchor"},
  "Beer": {"S": "Steam"},
  "Style": {"S": "Amber Lager"},
  "SRM": {"N": "15"},
  "IBU": {"N": "20"},
  "ABV": {"N": "4.9"}
  }
  ITEM
}

resource "aws_dynamodb_table_item" "mt_black_house" {
  table_name = "${aws_dynamodb_table.beers.name}"
  hash_key   = "${aws_dynamodb_table.beers.hash_key}"
  range_key   = "${aws_dynamodb_table.beers.range_key}"

  item = <<ITEM
  {
  "Brewery": {"S": "Modern Times"},
  "Beer": {"S": "Black House"},
  "Style": {"S": "Coffee Stout"},
  "SRM": {"N": "40"},
  "IBU": {"N": "40"},
  "ABV": {"N": "5.8"}
  }
  ITEM
}


data "aws_iam_policy_document" "dynamodb_beers_read" {
  statement {
    sid = "1"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeTimeToLive",
    ]

    resources = [
      "${aws_dynamodb_table.beers.arn}",
    ]
  }

  statement {
    sid = "2"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeLimits",
      "dynamodb:ListGlobalTables",
      "dynamodb:DescribeGlobalTable",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "dynamodb_beers_read" {
  name   = "${local.db_name}-read"
  path   = "/"
  policy = "${data.aws_iam_policy_document.dynamodb_beers_read.json}"
}

output "dynamodb_beers_output" {
  value = <<EOF


export DYNAMODB_READ_ONLY_ARN="${aws_iam_policy.dynamodb_beers_read.arn}"
export DYNAMODB_BEERS_TABLE_ARN="${aws_dynamodb_table.beers.arn}"
export DYNAMO_BEERS_TABLE_NAME="${var.owner}-vault-demo-beers"

EOF
}

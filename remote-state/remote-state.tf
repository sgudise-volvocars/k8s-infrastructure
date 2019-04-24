variable domain_name { default = "tekgs.io" }
variable network_cidr { default = "10.16.0.0/16" }


# Remove profile  after test
provider aws {
    region = "us-west-2"
}


variable tags {
    type = "map"
    default {
        Name = "Samson Gudise"
        Purpose = "dev"
    }
}

# dev hostedzone
data "aws_vpc" "selected" {
//   provider   = "aws.uswest2"
  cidr_block = "${var.network_cidr}"
}

resource "aws_route53_zone" "private" {
//   provider   = "aws.uswest2"
  name = "dev.${var.domain_name}"
  vpc {
    vpc_id = "${data.aws_vpc.selected.id}"
  }
}

# dev us-west-2
module  dev-s3-uswest2 {
    region = "us-west-2"
    dynamodb_table_name = "uswest2.dev.${var.domain_name}"
    s3bucket-name = "uswest2.dev.${var.domain_name}"
    tags = "${var.tags}"
    source  = "../../aws-infrastructure/remote-state"
}

# dev us-east-1
module  dev-s3-east-1 {
    region = "us-east-1"
    dynamodb_table_name = "useast1.dev.${var.domain_name}"
    s3bucket-name = "useast1.dev.${var.domain_name}"
    tags = "${var.tags}"
    source  = "../../aws-infrastructure/remote-state"
}
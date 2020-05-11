locals {
  nsgs = [ "cvc-test-meet-rg" ]
  project_prefix = "cvc"
  rg_tags  = {
    component    = "${var.project_tag_component}"
    owner        = "${var.tags_value_default["owner"]}"  
    environment  = "${var.tags_value_default["environment"]}"
    name         = "${local.project_prefix}-rg"
    namespace    = "${var.tags_value_default["namespace"]}"
    product      = "${var.tags_value_default["product"]}"
  }
  nsg_tags = {

    component    = "${var.project_tag_component}"
    owner        = "${var.tags_value_default["owner"]}"  
    environment  = "${var.tags_value_default["environment"]}"
    name         = "${local.project_prefix}-rg"
    namespace    = "${var.tags_value_default["namespace"]}"
    product      = "${var.tags_value_default["product"]}"

  }
}
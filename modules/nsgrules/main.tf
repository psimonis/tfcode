locals {
  project = strrev(split("/",strrev("${var.filepath}"))[0])
  raw_lines = [
      for line1 in split("\n", file("${var.filepath}/${local.project}_${var.environment_id}_nsgrules.csv")): 
      line1 if length(line1) > 0 && substr(line1, 0, 1) != "#"
    
    ]
      lines = [
      for line in local.raw_lines : {
      priority = split(";",line)[1]
      direction = split(";",line)[0]
      sources = split(",",split(";",line)[2])
      sports= split(",",split(";",line)[3])
      destinations = split(",",split(";",line)[4])
      protocol = split(";",line)[5]
      dports = split(",",split(";",line)[6])
      action = split(";",line)[7]
      description = split(";",line)[8]
      name = split(";",line)[9]

      # Lets try to support more than one destination 

    }
  ]
}


resource "azurerm_network_security_rule" "rule" {
  count = length(local.lines)

  

  name                        = local.lines[count.index].name

  priority                    = local.lines[count.index].priority
  direction                   = local.lines[count.index].direction
  access                      = local.lines[count.index].action
  protocol                    = local.lines[count.index].protocol
  source_port_range           = "${length(local.lines[count.index].sports) == 1 ? local.lines[count.index].sports[0] : null}"
  source_port_ranges          = "${length(local.lines[count.index].sports) > 1 ? local.lines[count.index].sports : null}"

  destination_port_range      = "${length(local.lines[count.index].dports) == 1 ? local.lines[count.index].dports[0] : null}"
  destination_port_ranges    = "${length(local.lines[count.index].dports) > 1 ? local.lines[count.index].dports : null}"
  source_address_prefix       = "${length(local.lines[count.index].sources) == 1 && substr(local.lines[count.index].sources[0],0,3) != "ASG" ? local.lines[count.index].sources[0] : null}"
  source_address_prefixes       = "${length(local.lines[count.index].sources) > 1 && substr(local.lines[count.index].sources[0],0,3) != "ASG" ? local.lines[count.index].sources : null}"
  source_application_security_group_ids = "${
substr(local.lines[count.index].sources[0],0,3) == "ASG"
            ?  split(",",format("%s%s","/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationSecurityGroups/",substr(join(",/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationSecurityGroups/",local.lines[count.index].sources),4,-1)))
            : null
}"

  destination_address_prefix  = "${length(local.lines[count.index].destinations) == 1 && substr(local.lines[count.index].destinations[0],0,3) != "ASG" ? local.lines[count.index].destinations[0] : null}"
  destination_address_prefixes  = "${length(local.lines[count.index].destinations) > 1 && substr(local.lines[count.index].destinations[0],0,3) != "ASG" ? local.lines[count.index].destinations : null}"
  destination_application_security_group_ids = "${
substr(local.lines[count.index].destinations[0],0,3) == "ASG"

            ?  split(",",format("%s%s","/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationSecurityGroups/",substr(join(",/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationSecurityGroups/",local.lines[count.index].destinations),4,-1)))
            : null
}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
}


output "Lines" {
  value = local.lines
}
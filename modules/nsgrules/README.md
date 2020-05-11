# Network Security Rules Module
This module currently supports reading a txt file from the directory of the calling code to create nsg rules

		Supported: 
			  - Direction
			  - Priority
			  - Source IP ( single )
			  - Destination IP ( 1/N )
			  - Destination ASG ( 1/N *) * multiple ASGS as destination are not currently supported by Azure, however we have written the code to enable it.
			  - protocolo (single)
			  - Destination Ports (1/N)
			  - Action
			  - Description 
			  - Name ( from file )
	    Not Supported:

## Network Security Rules Variables
<table border="1">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Required</th>
  </tr>
  <tr>
      <td>environment_id</td>
      <td>string</td>
      <td>yes</td>
  </tr>
  <tr>
      <td>resource_group_name</td>
      <td>string</td>
      <td>yes</td>
  </tr>
   <tr>
      <td>filepath</td>
      <td>string</td>
      <td>yes</td>
  </tr>
   <tr>
      <td>network_security_group_name</td>
      <td>string</td>
      <td>yes</td>
  </tr>
   <tr>
      <td>azure_subscription_id</td>
      <td>string</td>
      <td>yes</td>
  </tr>
</table>

## Example
```
module "nsgrules" {
  source = "../modules/nsgrules"
  filepath = "${path.cwd}"
  environment_id = "t"
  resource_group_name = "resource-group-name"
  network_security_group_name = "network-security-group-name"
  azure_subscription_id = "000000-00000-0000000-000000"
}
```
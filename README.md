
# terraform-gcp-bastion

The beginnings of a bastion module for gcp

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| image | The Base image used | string | n/a | yes |
| machine\_type | The machine type for the Bastion | string | `"n1-standard-1"` | no |
| name | The name of the Bastion Instance | string | `"bastion"` | no |
| project | The GCP project | string | n/a | yes |
| source\_cidrs | The ranges to allow to connect to the bastion | list | n/a | yes |
| subnetwork | The subnet name | string | n/a | yes |
| subnetwork\_project |  | string | n/a | yes |
| tags |  | list | `[ "bastion" ]` | no |
| vpc\_name | The name of the vpc for the firewall to be created in | string | n/a | yes |
| zone | The GCP zone | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# terraform-gcp-bastion

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-bastion/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-bastion)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-bastion.svg)](https://github.com/JamesWoolfenden/terraform-gcp-bastion/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-bastion.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-bastion/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-gcp-bastion/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-gcp-bastion&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-gcp-bastion/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-gcp-bastion&benchmark=INFRASTRUCTURE+SECURITY)

The beginnings of a bastion module for GCP, now with compute firewall options.
The Bastion is designed to work primarily with a private Kubernetes Cluster and is enabled for OS Logins. You'll need to add the service role an OS role to your users they will be able to SSH into it.
Basic Kubernetes tools are also installed into the bastion by **default**.

2 examples are included, one with and one without a static IP.
To find the image family and project:

```cli
gcloud compute images list
```

```cli
gcloud kms locations list
gcloud kms keyrings create --location=europe-west1 examplea
```

## Usage

Add **module.bastion.tf** to your code:-

```terraform
module "bastion" {
  source             = "JamesWoolfenden/bastion/gcp"
  version            = "0.1.13"
  image              = var.image
  name               = var.name
  network_interface  = var.network_interface
  project            = var.project
  service_email      = var.service_email
  source_cidrs       = var.source_cidrs
  zone               = var.zone
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.ssh-bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_image.image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up | `number` | `0` | no |
| <a name="input_image"></a> [image](#input\_image) | Describes the base image used | `map(any)` | n/a | yes |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | n/a | `string` | `"pike"` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | n/a | `string` | `"bastion"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type for the Bastion | `string` | `"n1-standard-1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Bastion Instance | `string` | `"bastion"` | no |
| <a name="input_nat_ip"></a> [nat\_ip](#input\_nat\_ip) | Values set if using a Static IP | `any` | `null` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | n/a | `map(any)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The GCP project | `string` | n/a | yes |
| <a name="input_service_email"></a> [service\_email](#input\_service\_email) | Service account username | `string` | n/a | yes |
| <a name="input_service_scope"></a> [service\_scope](#input\_service\_scope) | n/a | `list(any)` | <pre>[<br>  "https://www.googleapis.com/auth/cloud-platform"<br>]</pre> | no |
| <a name="input_source_cidrs"></a> [source\_cidrs](#input\_source\_cidrs) | The ranges to allow to connect to the bastion | `list(any)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Hard-coded tags that associates the correct firewall to the instance | `list(any)` | <pre>[<br>  "bastion-ssh"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion"></a> [bastion](#output\_bastion) | The Attributes of the Bastion |
| <a name="output_firewall"></a> [firewall](#output\_firewall) | The Attributes of the firewall |
| <a name="output_image"></a> [image](#output\_image) | The Attributes of the Image |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
resource "google_project_iam_custom_role" "terraformXVlBzgba" {
  project     = "examplea"
  role_id     = "terraform_pike"
  title       = "terraformXVlBzgba"
  description = "A user with least privileges"
  permissions = [
    "compute.addresses.create",
    "compute.addresses.delete",
    "compute.addresses.get",
    "compute.disks.create",
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.networks.updatePolicy",
    "compute.networks.use",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.serviceAccounts.get"
  ]
}

```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Information


## Related Projects

Check out these related projects.

- [terraform-aws-codecommit](https://github.com/jameswoolfenden/terraform-aws-codebuild) - Storing ones code

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-bastion/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-bastion/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2022 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150

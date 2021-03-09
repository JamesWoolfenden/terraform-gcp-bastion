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
| google | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) |
| [google_compute_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) |
| [google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) |
| [google_compute_project_metadata_item](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| firewall | Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up | `number` | `0` | no |
| image | Describes the base image used | `map(any)` | n/a | yes |
| keyring | n/a | `string` | `"examplea"` | no |
| kms\_key\_name | n/a | `string` | `"bastion"` | no |
| location | n/a | `string` | `"europe-west1"` | no |
| machine\_type | The machine type for the Bastion | `string` | `"n1-standard-1"` | no |
| name | The name of the Bastion Instance | `string` | `"bastion"` | no |
| nat\_ip | Values set if using a Static IP | `any` | `null` | no |
| network\_interface | n/a | `map(any)` | n/a | yes |
| project | The GCP project | `string` | n/a | yes |
| service\_email | Service account username | `string` | n/a | yes |
| service\_scope | n/a | `list(any)` | <pre>[<br>  "https://www.googleapis.com/auth/cloud-platform"<br>]</pre> | no |
| source\_cidrs | The ranges to allow to connect to the bastion | `list(any)` | n/a | yes |
| tags | Hard-coded tags that associates the correct firewall to the instance | `list(any)` | <pre>[<br>  "bastion-ssh"<br>]</pre> | no |
| zone | The GCP zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion | The Attributes of the Bastion |
| firewall | The Attributes of the firewall |
| image | The Attributes of the Image |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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

Copyright © 2019-2021 James Woolfenden

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
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-bastion&url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-bastion&url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_email]: mailto:?subject=terraform-aws-bastion&body=https://github.com/jameswoolfenden/terraform-aws-bastion

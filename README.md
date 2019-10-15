[![Slalom][logo]](https://slalom.com)

# terraform-gcp-bastion [![Build Status](https://api.travis-ci.com/JamesWoolfenden/terraform-gcp-bastion.svg?branch=master)](https://travis-ci.com/JamesWoolfenden/terraform-gcp-bastion) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-bastion.svg)](https://github.com/JamesWoolfenden/terraform-gcp-bastion/releases/latest)

The beginnings of a bastion module for GCP, now with compute firewall.
The bastion is designed to work with a private Kubernetes Cluster.
The Bastion is enabled for OS Logins, if you add the service role and
 OS role to your users they will be able to ssh into it.
The some basic Kubernetes tools are also installed into the bastion.

## Usage

Add **module.bastion.tf** to your code:-

```terraform
module "bastion" {
  source             = "../../"
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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| firewall | Flag to control the creation or not of a firewall rule. Maybe not needed if use a pre-prepared or shared set-up | number | `"0"` | no |
| image | Describes the base image used | map | n/a | yes |
| machine\_type | The machine type for the Bastion | string | `"n1-standard-1"` | no |
| name | The name of the Bastion Instance | string | `"bastion"` | no |
| network\_interface |  | map | n/a | yes |
| project | The GCP project | string | n/a | yes |
| service\_email | Service account username | string | n/a | yes |
| service\_scope |  | list | `[ "https://www.googleapis.com/auth/cloud-platform" ]` | no |
| source\_cidrs | The ranges to allow to connect to the bastion | list | n/a | yes |
| tags | Hardcoded tags that associates the correct firewall to the instance | list | `[ "bastion-ssh" ]` | no |
| zone | The GCP zone | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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

Copyright � 2019-2019 [Slalom, LLC](https://slalom.com)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

  [![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

  [jameswoolfenden_homepage]: https://github.com/jameswoolfenden
  [jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150

[logo]: https://gist.githubusercontent.com/JamesWoolfenden/5c457434351e9fe732ca22b78fdd7d5e/raw/15933294ae2b00f5dba6557d2be88f4b4da21201/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom

[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-bastion&url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-bastion&url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-bastion
[share_email]: mailto:?subject=terraform-aws-bastion&body=https://github.com/jameswoolfenden/terraform-aws-bastion

# terraform-gcp-bastion

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-bastion/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-bastion)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-bastion.svg)](https://github.com/JamesWoolfenden/terraform-gcp-bastion/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-bastion.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-bastion/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

A bastion module for GCP, built around the modern, no-external-IP pattern: the
instance has **no public IP and no SSH port exposed to the internet**. Access
is exclusively through [Identity-Aware Proxy TCP forwarding](https://cloud.google.com/iap/docs/using-tcp-forwarding),
governed entirely by IAM + OS Login and fully audited via Cloud Audit Logs.
The Bastion is designed to work primarily with a private Kubernetes Cluster and is enabled for OS Logins.
Basic Kubernetes tools are also installed into the bastion by **default** — one of its
main purposes is debugging Helm installations against a private cluster — including
the [GitLab agent](https://docs.gitlab.com/user/clusters/agent/install/) chart
(`gitlab/gitlab-agent` from `https://charts.gitlab.io`) — so `kubectl` and `helm`
need to be reliably present and usable from day one.

> **Locked-down networks:** because the bastion has no external IP, `init_script`
> steps that reach out to public apt/Helm repos (`pkgs.k8s.io`, `baltocdn.com`,
> etc.) will fail without Cloud NAT and an explicit egress allowlist. If your
> network doesn't permit that, prefer one of:
>
> - **Artifact Registry remote repositories** — proxy upstream apt and Helm
>   sources, including third-party chart repos like `charts.gitlab.io`, through
>   your own project, so the bastion only needs to reach `*.pkg.dev`, which is
>   typically already allowed for GCP-native traffic — handy for the charts
>   you're actively debugging too.
> - **Bake the tools into the image** (e.g. with Packer) so `init_script` needs
>   no runtime network access at all — more rigid to version-bump, but works
>   with zero egress.

Security controls enforced by the module (not configurable):

- No external IP — `access_config` is never created
- Firewall ingress restricted to Google's fixed IAP TCP forwarding range (`35.235.240.0/20`) on port 22, with flow logging enabled
- OS Login enabled, project SSH keys blocked
- Shielded VM: Secure Boot, vTPM, integrity monitoring
- Customer-managed encryption key (CMEK) required for the boot disk

To find the image family and project:

```cli
gcloud compute images list
```

```cli
gcloud kms locations list
gcloud kms keyrings create --location=europe-west1 pike
gcloud kms keys create bastion --location=europe-west1 --keyring=pike --purpose=encryption
```

## Access

Once `iap_members` has granted a principal `roles/iap.tunnelResourceAccessor`
(and they hold OS Login, e.g. `roles/compute.osLogin`), they can reach the
bastion with no further network setup:

```cli
gcloud compute ssh bastion --zone europe-west2-a --tunnel-through-iap
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
  account_id         = var.account_id
  iap_members        = ["user:alice@example.com"]
  zone               = var.zone
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_compute_firewall.ssh-bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_iap_tunnel_instance_iam_member.accessor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_tunnel_instance_iam_member) | resource |
| [google_kms_crypto_key_iam_member.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_compute_image.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_kms_crypto_key.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_crypto_key) | data source |
| [google_kms_key_ring.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |
| [google_project.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The ID of the service account for the bastion host | `string` | n/a | yes |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Flag to control the creation or not of a firewall rule. Maybe not needed if you use a pre-prepared or shared set-up | `number` | `0` | no |
| <a name="input_iap_members"></a> [iap\_members](#input\_iap\_members) | IAM members granted roles/iap.tunnelResourceAccessor on this bastion, e.g. ["user:alice@example.com", "group:ops@example.com"]. Required - with no external IP and no public SSH ingress, this is the only way anyone reaches the bastion. | `list(string)` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Describes the base image used | `map(any)` | n/a | yes |
| <a name="input_init_script"></a> [init\_script](#input\_init\_script) | The initialization script for the bastion host | `string` | n/a | yes |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | The keyring to use for the bastion host | `string` | `"pike"` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | The name of the KMS key to use for encrypting the boot disk of the bastion host | `string` | `"bastion"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the keyring and the KMS key | `string` | `"europe-west1"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type for the Bastion | `string` | `"n1-standard-1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Bastion Instance | `string` | `"bastion"` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | The network interface configuration for the bastion host | `map(any)` | n/a | yes |
| <a name="input_service_scope"></a> [service\_scope](#input\_service\_scope) | The scopes to assign to the service account of the bastion host | `list(any)` | <pre>[<br/>  "https://www.googleapis.com/auth/logging.write",<br/>  "https://www.googleapis.com/auth/monitoring.write"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Hard-coded tags that associates the correct firewall to the instance | `list(any)` | <pre>[<br/>  "bastion-ssh"<br/>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bastion"></a> [bastion](#output\_bastion) | The Attributes of the Bastion |
| <a name="output_firewall"></a> [firewall](#output\_firewall) | The Attributes of the firewall |
| <a name="output_image"></a> [image](#output\_image) | The Attributes of the Image |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang

resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "cloudkms.cryptoKeys.get",
    "cloudkms.cryptoKeys.getIamPolicy",
    "cloudkms.cryptoKeys.setIamPolicy",
    "cloudkms.keyRings.get",
    "compute.disks.create",
    "compute.disks.setLabels",
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setLabels",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.instances.stop",
    "compute.instances.updateNetworkInterface",
    "compute.networks.updatePolicy",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",
    "iap.tunnelInstances.getIamPolicy",
    "iap.tunnelInstances.setIamPolicy",
    "resourcemanager.projects.get"
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

Copyright © 2019-2026 James Woolfenden

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

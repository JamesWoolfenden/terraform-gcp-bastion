resource "google_project_iam_custom_role" "terraformXVlBzgba" {
  project     = "pike"
  role_id     = "terraform_pike"
  title       = "terraformXVlBzgba"
  description = "A user with least privileges"
  permissions = [
    "compute.disks.create",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.networks.get",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.serviceAccounts.get",
    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.buckets.get",
    "storage.buckets.update",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get"
  ]
}

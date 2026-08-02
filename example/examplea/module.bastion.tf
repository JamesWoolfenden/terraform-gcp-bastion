# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
#
# This bastion has no external IP. Reach it via Identity-Aware Proxy TCP forwarding:
#   gcloud compute ssh bastion --zone europe-west2-a --tunnel-through-iap
# which requires the connecting principal to hold roles/iap.tunnelResourceAccessor
# (granted below via iap_members) plus OS Login (already enabled by the module).
module "bastion" {
  source            = "../../"
  account_id        = var.account_id
  image             = var.image
  name              = var.name
  network_interface = var.network_interface
  zone              = var.zone
  kms_key_id        = google_kms_crypto_key.bastion.id
  init_script       = file("install-kube.sh")
  iap_members       = var.iap_members
}

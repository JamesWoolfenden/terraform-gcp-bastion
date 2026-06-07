# Grants roles/iap.tunnelResourceAccessor scoped to just this instance — the
# actual access-control surface for an IAP-only bastion (replacing source_cidrs).
# Members also need OS Login (roles/compute.osLogin or osAdminLogin) to complete
# `gcloud compute ssh <name> --tunnel-through-iap`.
resource "google_iap_tunnel_instance_iam_member" "accessor" {
  for_each = toset(var.iap_members)

  zone     = var.zone
  instance = google_compute_instance.bastion.name
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.value
}

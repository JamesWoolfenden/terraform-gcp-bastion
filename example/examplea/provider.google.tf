# holden:ignore:HLD_GCP_059 — per-repo WIF SA with attribute.repository scoping
# provides equivalent least-privilege without impersonation.
provider "google" {
  default_labels = {
    environment = var.environment
    team        = var.team
    managed_by  = "terraform"
  }
}

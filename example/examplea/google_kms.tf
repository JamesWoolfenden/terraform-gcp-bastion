# Demonstrates the caller owning the KMS key the bastion module encrypts its
# boot disk with. KMS keyrings cannot be deleted, so re-running this example
# against a keyring that already exists in the project will fail to recreate it.
resource "google_kms_key_ring" "examplea" {
  name     = "examplea"
  location = "europe-west2"
}

resource "google_kms_crypto_key" "bastion" {
  name            = "bastion"
  key_ring        = google_kms_key_ring.examplea.id
  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = true
  }
}

# CMEK for the bastion's boot disk. var.kms_key_id points at a key the caller
# already owns (KMS keyrings cannot be deleted, so a reusable module should
# reference centrally-managed key infrastructure rather than own its lifecycle).

# The Compute Engine service agent must hold cloudkms.cryptoKeyEncrypterDecrypter
# on the CMEK key before the instance can be created with an encrypted boot disk.
# Its identity is fixed by Google's naming convention and not user-suppliable.
resource "google_kms_crypto_key_iam_member" "bastion" {
  crypto_key_id = var.kms_key_id
  member        = "serviceAccount:service-${data.google_project.bastion.number}@compute-system.iam.gserviceaccount.com"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

data "google_project" "bastion" {
}

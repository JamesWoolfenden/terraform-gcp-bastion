# CMEK for the bastion's boot disk. The keyring and key are expected to
# already exist (KMS keyrings cannot be deleted, so a reusable module should
# reference centrally-managed key infrastructure rather than own its lifecycle).
data "google_kms_key_ring" "bastion" {
  name     = var.keyring
  location = var.location
}

data "google_kms_crypto_key" "bastion" {
  name     = var.kms_key_name
  key_ring = data.google_kms_key_ring.bastion.id
}

# The Compute Engine service agent must hold cloudkms.cryptoKeyEncrypterDecrypter
# on the CMEK key before the instance can be created with an encrypted boot disk.
# Its identity is fixed by Google's naming convention and not user-suppliable.
resource "google_kms_crypto_key_iam_member" "bastion" {
  crypto_key_id = data.google_kms_crypto_key.bastion.id
  member        = "serviceAccount:service-${data.google_project.bastion.number}@compute-system.iam.gserviceaccount.com"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

data "google_project" "bastion" {
}

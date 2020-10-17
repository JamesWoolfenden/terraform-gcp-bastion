resource "google_kms_crypto_key" "pd" {
  name            = var.kms_key_name
  rotation_period = "100000s"
  key_ring        = var.keyring
}

resource "google_compute_project_metadata_item" "enable-oslogin" {
  key = "enable-oslogin"
  value = "TRUE"
}

#gcloud compute project-info add-metadata --metadata enable-oslogin=TRUE

resource "google_project" "my_project" {
  name       = "gcp-vm-class1-26thapril"
  project_id = "gcp-vm-class1-26thapril"
  billing_account = "013CAA-2F6A8D-77E218"
}

resource "google_service_account" "service_account" {
  account_id   = "siperman-compute"
  display_name = "Service Account"
  project = google_project.my_project.project_id
}

resource "google_project_service" "project" {
  project = google_project.my_project.project_id
  service = "compute.googleapis.com"

  disable_dependent_services = true
}
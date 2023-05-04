provider "google" {
  credentials = var.gcp_auth_file
  project = var.gcp_project_id
  region = var.gcp_region
}
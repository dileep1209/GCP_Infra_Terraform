provider "google" {
  credentials = "${file("credentials.json")}"
  project = "kubernates-practice-380905"
  region = "us-central1-c"
}
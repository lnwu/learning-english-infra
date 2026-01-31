terraform {
  required_version = ">= 1.10.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 7.0"
    }
  }
}

resource "google_project" "learning_english" {
  project_id = "learning-english-477407"
  name       = "learning-english"
}

resource "google_project_service" "firebase" {
  disable_on_destroy = true
  project            = google_project.learning_english.project_id
  service            = "firebase.googleapis.com"
}

resource "google_project_service" "firestore" {
  service            = "firestore.googleapis.com"
  disable_on_destroy = true
  depends_on         = [google_project_service.firebase]
}

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.learning_english.project_id

  depends_on = [google_project_service.firebase]
}

resource "google_firebase_web_app" "default" {
  provider     = google-beta
  project      = google_project.learning_english.project_id
  display_name = "Learning English Web"

  depends_on = [google_firebase_project.default]
}

resource "google_firestore_database" "default" {
  provider    = google-beta
  project     = google_project.learning_english.project_id
  name        = "(default)"
  location_id = "asia-east2"
  type        = "FIRESTORE_NATIVE"

  depends_on = [google_project_service.firestore]
}

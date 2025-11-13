terraform {
  backend "gcs" {
    bucket = "learning-english-terraform-state"
    prefix = "terraform/state"
  }
}

# Main Terraform Configuration
# This file contains core GCP project resources

# Enable required Google Cloud APIs
# Uncomment and customize as needed for your project

# resource "google_project_service" "required_apis" {
#   for_each = toset([
#     "firebase.googleapis.com",
#     "firestore.googleapis.com",
#     "identitytoolkit.googleapis.com",
#     "iap.googleapis.com",
#   ])
#   
#   project = var.project_id
#   service = each.key
#   
#   disable_on_destroy = false
# }

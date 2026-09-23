terraform {
  backend "gcs" {
    bucket = "foodtrack-b-tfstate-form-gke-eleve02-618b"
    prefix = "terraform/state"
  }
}

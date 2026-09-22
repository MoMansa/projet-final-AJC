terraform {
  backend "gcs" {
    bucket = "foodtrack-b-tfstate-poei-formation-gcp"
    prefix = "terraform/state"
  }
}
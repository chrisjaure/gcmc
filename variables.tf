variable "account_file" {}
variable "project" {}
variable "region" {
	default = "us-central1"
}
variable "zones" {
	default {
		us-central1 = "us-central1-a"
		europe-west1 = "europe-west1-b"
		east-asia1 = "east-asia1-a"
	}
}
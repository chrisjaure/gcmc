variable "account_file" {}
variable "ssh_path" {}
variable "project" {}
variable "region" {
	default = "us-central1"
}
variable "disk_image" {
	default = "coreos-stable-633-1-0-v20150414"
}
variable "machine_type" {
	default = "n1-standard-1"
}
variable "zones" {
	default {
		us-central1 = "us-central1-a"
		europe-west1 = "europe-west1-b"
		east-asia1 = "east-asia1-a"
	}
}
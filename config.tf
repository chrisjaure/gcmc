# Configure the Google Cloud provider
provider "google" {
    account_file = "${var.account_file}"
    project = "${var.project}"
    region = "${var.region}"
}

resource "google_compute_network" "default" {
    name = "minecraft-network"
    ipv4_range = "10.240.0.0/16"
}

resource "google_compute_firewall" "default" {
    name = "minecraft-port"
    network = "${google_compute_network.default.name}"

    allow {
        protocol = "tcp"
        ports = ["25565"]
    }

    allow {
        protocol = "udp"
        ports = ["25565"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "default" {
    name = "minecraft-address"
}

resource "google_compute_instance" "minecraft" {
    name = "minecraft-instance"
    machine_type = "n1-standard-1"
    zone = "${lookup(var.zones, var.region)}"

    disk {
        image = "coreos-stable-633-1-0-v20150414"
    }

    network_interface {
        network = "${google_compute_network.default.name}"
        access_config {
        	nat_ip = "${google_compute_address.default.address}"
        }
    }

    address = "${google_compute_address.default.name}"
}
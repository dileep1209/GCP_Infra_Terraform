resource "google_compute_instance" "default" {
    name = "virtual-machine-from-terraform"
    machine_type = "e2-standard-4"
    zone = "us-central1-c"

    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2004-lts"
      }
    }

    network_interface {
      network = "default"

      access_config {
        
      }
    }

    metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Welcome to Apache Server</h1></body></html>' | sudo tee /var/www/html/index.html"

    tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name = "terraform-http-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["22","80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}
output "ip"{
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
  }
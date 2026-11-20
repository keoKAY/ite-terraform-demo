terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

# config the provider in order to create resources from the provide
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  zone        = var.zone
  region      = var.region
}

variable "instances" {
  description = "Configuration for each VM"
  type = map(object({
    machine_type = string
    disk_size    = number
    disk_type    = string
    image        = string
  }))

  default = {
    "master" = {
      machine_type = "e2-standard-2"
      disk_size    = 48
      disk_type    = "pd-balanced"
      image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"

    }

    worker1 = {
      machine_type = "e2-standard-2"
      disk_size    = 28
      disk_type    = "pd-balanced"
      image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
    worker2 = {
      machine_type = "e2-medium"
      disk_size    = 28
      disk_type    = "pd-balanced"
      image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }
}

resource "google_compute_instance" "vms" {
  for_each     = var.instances
  name         = each.key # master,worker1,worker2
  machine_type = each.value.machine_type
  zone         = var.zone

  # need to add this in order allow updates when resources changes 
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = each.value.image
      size  = each.value.disk_size
      type  = each.value.disk_type
    }
  }

  network_interface {
    network = var.network
    access_config {
      # Assign ephemeral public IP 
    }
  }

  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }

}
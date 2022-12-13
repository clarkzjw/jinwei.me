terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.36.1"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

variable "ip_range" {
  default = "10.0.1.0/24"
}

resource "hcloud_ssh_key" "framework" {
  name       = "framework"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILS2i5/x9r+cv2j2/SUZ2x2fgQeGnJP1I7PUHC0UdWN6 framework"
}

data "hcloud_image" "debian" {
  name = "debian-11"
}

resource "hcloud_server" "default" {
  name        = "photo"
  image       = data.hcloud_image.debian.name
  server_type = "cpx11"
  location    = "fsn1"
  ssh_keys    = [hcloud_ssh_key.framework.id]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.primary_ip_1.id
  }
  delete_protection  = false
  rebuild_protection = false

  firewall_ids = [hcloud_firewall.default.id]
}

resource "hcloud_primary_ip" "primary_ip_1" {
  name          = "primary_ip_test"
  datacenter    = "fsn1-dc14"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
}

resource "hcloud_firewall" "default" {
  name = "default"
}

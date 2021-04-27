resource "google_compute_instance" "default" {
  count        = 2
  name         = "${var.computer_name}${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  project      =  var.projectid
  tags         = ["foo", "bar", "terraform", "dev"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #  interface = "SCSI"
  #}

  network_interface {
    #count = 2
    #name    = "nic-${count.index}"
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    #Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_compute_emailid
    scopes = ["cloud-platform"]
  }
}

#resource "google_compute_project_metadata" "my_ssh_key" {
#    project = var.projectid
#    metadata = {
#    ssh-keys = <<EOF
#    sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJALcQ1lclxMI6NyCuCFgVvJhH9Jm2Xv/sokg2wmIB/AeUSoZrTQUYV6A7HD3c8ZHzbeDqvA+iMvVQFyHhjqycNajEAEgYOjzyw8eIFU0kt+dfOxdzSTc3v3LJRDMusNHlVeltnA/4lB+WSAHWWNSsRWPShfQF4EHT7vP6odZAYDekvtUmdibHzpRGyCwDaGojK/4cY59IEHKXGAplbctxI+5jBG13QvajT3iTpLfgM/agkB6+6HX6mmwg5WWhq1SOWrb+SfrZBH/vQb1vaGSWyzIs/M3sMWSdKykme2VFOjQBmLrNApb6Hw570lGZdD3NHP5EK89q2CMZkqZvltXLi4M8uxjeqj20BFRcokHaReBJsQBJs3EIJK39tTN8NKcJsX1fwZ1Uc3jZNt5kcHX6/a7sJElYsspYvmXS0txQ+6A9CMdlS4ovGlVO7LLTbKn4cyTcD+6RjAE3qFNZGNyMc6Lv6Y+vt70gieA6iL9fmflVbFr5DCkc7P1D8j2ohUSMp8Q03sr6jMCUUZDH8ICPrLHKqz5FtQtEHt7d9uDWaffgBbE7YdFSQT1O0J0xEKWJsSVtuWJC/B4VW73GC7Fl60W/XIzagJDifodmo12g3T8ywv5gXY5eGERcr0/ef4DRwAzYMgRsSas3whoNHLLT3LUis23X8YMOzwodT5NzSQ== myawesomeprojectuser
#    EOF
#  }
#}
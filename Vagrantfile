# -*- mode: ruby -*-
# vi: set ft=ruby :
require "yaml"

Vagrant.configure("2") do |config|

  # Load config
  if File.file?("local_config.yaml")
    local_config = YAML.load_file("local_config.yaml");
  else
    local_config = YAML.load_file("default_config.yaml");
  end

  config.vm.box = "centos/7"
  config.vm.define "Congress"
  config.vm.boot_timeout = 1200

  # Sync folders from host
  config.vm.synced_folder "synched", "/home/vagrant/congress-events"

#   config.vm.network "forwarded_port", guest: 5000, host: 5000
#   config.vm.network "forwarded_port", guest: 4000, host: 4000
#   config.vm.network "forwarded_port", guest: 80, host: 8080
#   config.vm.network "forwarded_port", guest: 8080, host: 8880
#   config.vm.network "forwarded_port", guest: 443, host: 4430

  config.vm.network "private_network", ip: "192.168.255.100"

  config.vm.provider "virtualbox" do |vb|

    vb.name = "Congress"

    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory and cpus on the VM:
    vb.memory = local_config["memory"];
    vb.cpus = local_config["cpus"];

    # VBox specific fixes
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected" ]

  end

  config.vm.provision "shell",
    name: "Install",
    path: "install.sh",
    env: {
      "PACKAGES" => File.read("REQUIRED_PACKAGES")
    }
  config.vm.provision "file",
    source: "ssh",
    destination: "/home/vagrant/.ssh"
  config.vm.provision "shell",
    name: "DB_config",
    env: {
      "DB_NAME" => local_config["db_name"],
      "DB_LOGIN" => local_config["db_login"],
      "DB_PASSWORD" => local_config["db_password"]
    },
    path: "postgres.sh"
    config.vm.provision "shell",
    name: "ssh",
    privileged: false,
    inline: <<-SHELL
      chmod 600 /home/vagrant/.ssh/*
    SHELL
#   config.vm.provision "shell",
#     name: "Git",
#     privileged: false,
#     inline: <<-SHELL
#       chmod 600 /home/vagrant/.ssh/*
#       if git clone git@github.com:EventsExpertsMIEM/EventsProj.git 2>/dev/null; then
#         cd /home/vagrant/EventsProj
#         git checkout mir_init-func
#       else
#         echo "Already cloned, skipping"
#       fi
#     SHELL
#   config.vm.provision "shell",
#         name: "Python_dependancies",
#         inline: "python3.6 -m pip install -r /home/vagrant/EventsProj/app/requirements.txt"
end

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
  
  # VBox plugin
  config.vagrant.plugins = ["vagrant-vbguest"]

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end
  
  config.vm.box = "centos/7"
  config.vm.define "Congress"
  config.vm.boot_timeout = 1200

  # Sync folders from host
  config.vm.synced_folder ".", "/home/vagrant/congress-events"

  config.vm.network "forwarded_port", guest: 8080, host: 8080

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
    #vb.customize ["modifyvm", :id, "--uartmode1", "disconnected" ]

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
  config.vm.provision "file",
    source: "pg_hba.conf",
    destination: "/home/vagrant/pg_hba.conf"
  config.vm.provision "shell",
    name: "DB_config",
    env: {
      "DB_NAME" => local_config["db_name"],
      "DB_LOGIN" => local_config["db_login"],
      "DB_PASSWORD" => local_config["db_password"]
    },
    path: "postgres.sh"
  config.vm.provision "shell",
    name: "Git",
    privileged: false,
    inline: <<-SHELL
      chmod 600 /home/vagrant/.ssh/*
      if git clone git@github.com:EventsExpertsMIEM/EventsProj.git 2>/dev/null; then
        echo "Cloned"
      else 
        echo "Already cloned, skipping"
      fi
    SHELL
  config.vm.provision "shell",
        name: "Python_dependancies",
        inline: "python3.6 -m pip install -r EventsProj/app/requirements.txt"
      
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

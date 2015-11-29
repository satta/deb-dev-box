# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # config.vm.box = "ffuenf/debian-8.0.0-amd64"
  config.vm.box = "debian-jessie"
  config.vm.box_check_update = false
  config.vbguest.auto_update = false

  # config.vm.network "public_network", bridge: "wlan0"
  config.vm.network "private_network", type: "dhcp"
  config.vm.network :forwarded_port, guest: 8000, host: 8800

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "/Users/satta", "/homedir"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.provision :shell, path: "bootstrap.sh"
end

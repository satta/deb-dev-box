# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-testing"
 # config.vm.box_check_update = false
 # config.vbguest.auto_update = false
  config.vm.network :private_network, ip: "10.11.12.13"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder "/Users/satta", "/homedir"
  config.vm.synced_folder ".", "/vagrant", type: :nfs
  config.bindfs.bind_folder "/vagrant", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 3072
    vb.cpus = 2
#    vb.customize ['modifyvm', :id, '--usb', 'on']
#    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Yubikey Neo', '--vendorid', '0x1050', '--productid', '0x0111']
  end

  config.vm.provision :shell, path: "bootstrap.sh"
end

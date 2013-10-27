# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # "vagrant box list" lists all the boxes. One of them should be used here
  config.vm.box = "base"

  # Additional synced folders (besides /vagrant) between the guest and the host machine.
  config.vm.synced_folder "srv", "/srv/"

  # Provisioner to use and the path to the file 
  config.vm.provision :shell, :path => "glassfish.sh"

  # The IP address that the guest machine can be accessed 
  config.vm.network :private_network, ip: "1.2.3.4"
end

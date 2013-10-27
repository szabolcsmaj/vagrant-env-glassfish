# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "base"

  config.vm.synced_folder "srv", "/srv/"

  config.vm.provision :shell, :path => "glassfish.sh"

  config.vm.hostname = "farmmix.dev"

  config.vm.network :private_network, ip: "1.2.3.4"
end

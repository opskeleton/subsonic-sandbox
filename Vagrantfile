# -*- mode: ruby -*-
# vi: set ft=ruby :

MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

update_ubuntu = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  device = ENV['VAGRANT_BRIDGE'] || 'eth0'
  pool = ENV['VAGRANT_POOL']
  env  = ENV['PUPPET_ENV'] || 'dev'

  config.vm.define :subsonic do |node|


    node.vm.provider 'libvirt'
    node.vm.box = 'ubuntu-16.04_puppet-3.8.7'
    node.vm.hostname = 'subsonic.local'

    node.vm.provider :libvirt do |domain, o|
	domain.uri = 'qemu+unix:///system'
	domain.host = 'subsonic.local'
	domain.memory = 2048
	domain.cpus = 2
	domain.storage_pool_name = pool if pool
	o.vm.synced_folder './', '/vagrant', type: 'nfs'
	o.vm.network :public_network, :bridge => device , :dev => device
    end

    node.vm.provision :shell, :inline => update_ubuntu
    node.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end
  end

end

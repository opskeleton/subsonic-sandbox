# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  device = ENV['VAGRANT_BRIDGE'] || 'eth0'
  pool = ENV['VAGRANT_POOL']
  env  = ENV['PUPPET_ENV'] || 'dev'

  config.vm.define :subsonic do |node|

    node.vm.box = 'ubuntu-16.04_puppet-3.8.7'
    node.vm.hostname = 'subsonic.local'

    node.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end
  end

end

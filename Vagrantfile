Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  #config.vm.network :hostonly, "33.33.33.10"
  config.vm.forward_port 80, 3000

  config.vm.share_folder("v-root", "/wordpress_project", ".")

  config.vm.customize ["modifyvm", :id, "--memory", "1024", "--hwvirtexexcl", "on"]

  config.vm.provision :puppet do |puppet|
    puppet.facter = { "fqdn" => "local.wordpress_project", "hostname" => "www" }
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end
end

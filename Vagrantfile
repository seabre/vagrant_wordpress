VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :forwarded_port, guest: 80, host: 3000
  config.vm.synced_folder ".", "/wordpress_project", owner: "www-data", group: "www-data"

  config.vm.provider "virtualbox" do |vb|
   vb.customize ["modifyvm", :id, "--memory", "1024", "--hwvirtex", "on"]
  end

  config.vm.provision "puppet" do |puppet|
   puppet.facter = { 
    "fqdn" => "local.wordpress_project", 
    "hostname" => "www",
# # # Provide the name of the project here # # #
    "project_name" => "NAME_YOUR_PROJECT"}
   puppet.manifests_path = 'puppet/manifests'
   puppet.manifest_file  = 'site.pp'
   puppet.module_path = 'puppet/modules'
  end
end
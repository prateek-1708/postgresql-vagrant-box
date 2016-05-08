Vagrant.configure(2) do |config|
    config.vm.box = "centos/7"
    config.vm.network "forwarded_port", guest: 5432, host: 45432
    config.vm.network "forwarded_port", guest: 80, host: 8991

    config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
    config.vm.synced_folder ".", "/vagrant"

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024] # 1 GB RAM
      vb.customize ["modifyvm", :id, "--chipset", "ich9"] # Modern ICH9 chipset
    end
    config.vm.provision "shell" do |shell|
      shell.path = 'bin/provision_pg.sh'
    end

end

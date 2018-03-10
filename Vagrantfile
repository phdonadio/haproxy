# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  box = "bento/centos-7.4"
  network = "192.168.99"
  mac_addr = "080027EDE36"

  [["web1", "#{network}.11", box, "#{mac_addr}1"], 
   ["web2", "#{network}.12", box, "#{mac_addr}2"]].each do |vm,ip,box,mac|
    config.vm.define "#{vm}" do |web|
      web.vm.box = "#{box}"
      web.vm.base_mac  = mac
      web.vm.hostname = "#{vm}.local"
      web.vm.network  "private_network", ip: "#{ip}", virtualbox__intnet: "web_network" 
      web.vm.synced_folder "saltstack/salt/", "/srv/salt"
      web.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus   = 1
        vb.name   = "#{vm}.local"
      end
      web.vm.provision :salt do |salt|
        salt.masterless = true
        salt.minion_config = "saltstack/etc/#{vm}_minion"
        salt.install_type = "stable"
        salt.run_highstate = true
        salt.verbose = true
        salt.colorize = true
      end 
    end
  end
  config.vm.define "haproxy" do |hap|
    hap.vm.box = "#{box}"
    hap.vm.hostname = "haproxy.local"

    hap.vm.network "private_network", ip: "#{network}.10", virtualbox__intnet: "web_network"
    hap.vm.base_mac = "080027EDE360"
    hap.vm.network "forwarded_port", guest: 80, host: 8080
    hap.vm.synced_folder "saltstack/salt/", "/srv/salt"

    hap.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus   =  2
        vb.name   = "haproxy"
    end
    hap.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "saltstack/etc/haproxy_minion"
      salt.install_type = "stable"
      salt.run_highstate = true
      salt.verbose = true
      salt.colorize = true
    end 
  end
end

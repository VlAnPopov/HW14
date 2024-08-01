# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  { :name => "prometheus", :ip => "192.168.56.110", :box => "ubuntu/jammy64", :memory => 2048, :cpus => 2, :script => 'prometheus.sh'},
  { :name => "zabbix", :ip => "192.168.56.111",  :box => "ubuntu/jammy64", :memory => 2048, :cpus => 2, :script => 'zabbix.sh'},
 ]

Vagrant.configure("2") do |config|
  boxes.each do |box|
    config.vm.define box[:name] do |target|
      target.vm.provider "virtualbox" do |v|
        v.name = box[:name]
        v.memory = box[:memory]
        v.cpus = box[:cpus]
      end
      target.vm.box = box[:box]
      target.vm.network "private_network", ip: box[:ip]
      target.vm.hostname = box[:name]
      target.vm.synced_folder ".", "/vagrant"
      target.vm.provision "shell", path: box[:script]
    end
  end
end
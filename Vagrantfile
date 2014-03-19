Vagrant.configure("2") do |config|
  config.vm.box = "ffuenf/ubuntu-13.10-server-amd64"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  %w[master slave1 slave2 slave3].each_with_index do |name, i|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: "10.0.0.#{100+i}"
      node.vm.provision "chef_solo" do |chef|
        chef.add_recipe "percona::server"
        chef.json = {
          :percona => {
            :skip_passwords   => true,
            :main_config_file => "/etc/mysql/my.cnf",
            :server => {
              :package                   => "percona-server-server-5.6",
              :debian_username           => "root",
              :bind_address              => "10.0.0.#{100+i}",
              :role                      => name.gsub(/\d/, ""),
              :binlog_format             => "ROW",
              :enforce_gtid_consistency  => "true",
              :gtid_mode                 => "on",
              :log_slave_updates         => true,
              :relay_log_info_repository => "TABLE",
              :relay_log_recovery        => "on",
              :server_id                 => i + 1,
              :sync_binlog               => 0,
            }
          }
        }
      end
      node.vm.provision "shell", inline: %Q{
        mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
      }
    end
  end
end

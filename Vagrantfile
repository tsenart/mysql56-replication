Vagrant.configure("2") do |config|
  config.vm.box = "ffuenf/ubuntu-13.10-server-amd64"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  (["master"] + ["slave"] * 4).each_with_index do |role, i|
    name = "%s.%d"     % [role, i]
    addr = "10.0.0.%d" % (100 + i)
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: addr
      node.vm.provision "chef_solo" do |chef|
        chef.add_recipe "percona::server"
        chef.json = {
          :percona => {
            :skip_passwords   => true,
            :main_config_file => "/etc/mysql/my.cnf",
            :server => {
              :package                   => "percona-server-server-5.6",
              :debian_username           => "root",
              :bind_address              => addr,
              :port                      => { "slave" => 3310, "master" => 3306 }[role],
              :role                      => role,
              :binlog_format             => "ROW",
              :enforce_gtid_consistency  => "true",
              :gtid_mode                 => "ON",
              :log_slave_updates         => true,
              :relay_log_info_repository => "TABLE",
              :master_info_repository    => "TABLE",
              :relay_log_recovery        => "ON",
              :report_host               => addr,
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

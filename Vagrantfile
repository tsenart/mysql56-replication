Vagrant.configure("2") do |config|
  config.vm.box = "ffuenf/ubuntu-13.10-server-amd64"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  %w[master slave1 slave2 slave3].each_with_index do |name, i|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: "10.0.0.1%d" % i
      node.vm.provision "chef_solo" do |chef|
        chef.add_recipe "percona::server"
        chef.json = {
          :percona => {
            :skip_passwords => true,
            :server => {
              :package                   => "percona-server-server-5.6",
              :debian_username           => "root",
              :bind_to                   => "private_ip",
            },
            :conf => {
              :mysqld => {
                :binlog_format             => "ROW",
                :enforce_gtid_consistency  => "true",
                :gtid_mode                 => "on",
                :log_bin                   => "#{name}.bin",
                :log_slave_updates         => true,
                :relay_log_info_repository => "TABLE",
                :relay_log_recovery        => "on",
                :relay_log                 => "#{name}-relay.bin",
                :server_id                 => i + 1,
                :sync_binlog               => 0,
              }
            }
          }
        }
      end
    end
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/zabbix-agent-3.0.1-1.el7.x86_64.rpm" do
    source "http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-agent-3.0.1-1.el7.x86_64.rpm"
    action :create
end

rpm_package "zabbix-agent" do
    source "#{Chef::Config[:file_cache_path]}/zabbix-agent-3.0.1-1.el7.x86_64.rpm "
    action :install
end

# rpm -Uvh http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/zabbix-agent-2.4.1-2.el7.x86_64.rpm

  # Define zabbix-agent service
  service 'zabbix-agent' do
    pattern 'zabbix_agentd'
    supports status: true, start: true, stop: true, restart: true
    action [:enable, :start]
    notifies :restart, 'service[zabbix-agent]', :delayed
  end
  
template "/etc/zabbix/zabbix_agentd.conf" do
  source	'zabbix_agentd.conf.erb'
  owner node['zabbix']['agent']['user']
  group node['zabbix']['agent']['group']
  mode 0600
  notifies :restart, 'service[zabbix-agent]', :delayed
end

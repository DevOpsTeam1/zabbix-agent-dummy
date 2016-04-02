# Manage user and group
user node['zabbix']['agent']['user'] do
  shell node['zabbix']['agent']['shell']
  system true
  supports manage_home: true
end
group node['zabbix']['agent']['group'] do
  action :create
  members node['zabbix']['agent']['user']
end


directory node['zabbix']['install_dir'] do
  owner node['zabbix']['agent']['user']
  group node['zabbix']['agent']['group']
  mode '755'
end
directory node['zabbix']['agent']['scripts'] do
  owner 'root'
  group 'root'
  mode '755'
  recursive true
end


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

# Install optional additional agent config file containing UserParameter(s)
#template 'user_params.conf' do
# path node['zabbix']['agent']['userparams_config_file']
#  source 'user_params.conf.erb'
#  unless node['platform_family'] == 'windows'
#    owner 'root'
#    group 'root'
#    mode '644'
#  end
#  notifies :restart, 'service[zabbix-agent]'
#  only_if { node['zabbix']['agent']['user_parameter'].length > 0 }
#end

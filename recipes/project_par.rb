# http://ruby-doc.org/core-2.1.6/Enumerable.html#method-i-find
zabbix_srv_hostname = node['epc-provisioning']['instances'].find { |i| i[1]['role'] == 'zabbix-srv' }[0]
zabbix_srv_ip = node['epc-provisioning']['instances'].find { |i| i[1]['role'] == 'zabbix-srv' }[1]['private_ip_address']

# notice the difference between `find` and `find_all`
# http://ruby-doc.org/core-2.1.6/Enumerable.html#method-i-find_all
# selection of a few machines which could be processed with `each` Ruby method afterwards
some_machines = node['epc-provisioning']['instances'].find_all { |i| i[1]['name'] =~ /^ECS/ }.map { |i| i[0] }

# accessing current machine attributes using node['epc-provisioning']['instance'] which always refers to the current machine
my_current_machine_id = node['epc-provisioning']['instance']['id']

Chef::Log.warn "First instance in our project with `zabbix-srv` role: #{zabbix_srv_hostname}"
Chef::Log.warn "IP address of a first instance in our project with `zabbix-srv` role: #{zabbix_srv_ip}"
Chef::Log.warn "Selection of some machines: #{some_machines.join(', ')}"
Chef::Log.warn "My current id: #{my_current_machine_id}"

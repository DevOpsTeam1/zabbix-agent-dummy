default['php']['install_method'] = 'source'

default['zabbix'] = {}
default['zabbix']['agent'] = {}
default['zabbix']['agent']['user']         = 'zabbix'
default['zabbix']['agent']['group']        = 'zabbix'
default['zabbix']['agent']['shell']        = '/bin/bash'

default['zabbix']['install_dir']      = '/opt/zabbix'
default['zabbix']['scripts']          = '/etc/zabbix/scripts'

default['zabbix']['agent']['version']     = '3.0'
default['zabbix']['agent']['hostname']    = node['epc-provisioning']['instances'].find { |i| i[1]['role'] == 'app-bundle' }[0]
normal['zabbix']['agent']['servers_name']   = node['epc-provisioning']['instances'].find { |i| i[1]['role'] == 'zabbix-srv' }[0]
normal['zabbix']['agent']['servers_ip']      = normal['zabbix']['agent']['servers_active'] = node['epc-provisioning']['instances'].find { |i| i[1]['role'] == 'zabbix-srv' }[1]['private_ip_address']

default['zabbix']['agent']['timeout']        = '3'
default['zabbix']['agent']['listen_port']    = '10050'
default['zabbix']['agent']['jmx_port']       = '10052'

default['zabbix']['agent']['conf']['LogType']      = 'system'
default['zabbix']['agent']['conf']['PidFile']      = '/var/run/zabbix/zabbix_agentd.pid'

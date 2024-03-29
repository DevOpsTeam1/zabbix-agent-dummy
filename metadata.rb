name 'zabbix-agent'
maintainer 'DevOpsTeam1'
license 'Apache 2.0'
description 'Installs/Configures Zabbix Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

# tested on centos 6.6 and 7.0
supports 'centos', '>= 6.6'
# tested on debian 6.0.10 and 7.0
supports 'debian', '>= 6.0.10'

# change the needed recommends to depends below
depends 'apt'             # For Debian family OSs
depends 'yum'             # For Redhat family OSs
depends 'build-essential' # for source build/install
recommends 'libzabbix'    # LWRPs to connect to zabbix server

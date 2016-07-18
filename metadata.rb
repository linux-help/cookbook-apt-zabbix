name             'apt-zabbix'
maintainer       'Eric Renfro'
maintainer_email 'psi-jack@linux-help.org'
license          'Apache 2.0'
description      'Installs and configures the NUX Community Desktop Yum Repository'
long_description ''
version          '0.1.0'
issues_url       'http://gogs.home.ld/Linux-Help/cookbook-apt-zabbix/issues'
source_url       'http://gogs.home.ld/Linux-Help/cookbook-apt-zabbix'

%w{ debian }.each do |os|
	supports os, '>= 5.0'
end

depends 'apt', '>= 3.0'


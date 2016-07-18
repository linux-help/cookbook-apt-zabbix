#
# Cookbook Name:: apt-zabbix
# Attributes:: default
#

# Debian-ish platform support for this cookbook and the Zabbix repository.
# Designed to be a private attribute however it can be overridden in the case
# Zabbix supports additional platforms and this cookbook has not been updated
# yet.
#
# This check was implemented as a result of the repo could be successfully
# installed yet not be valid for a given platform and an Zabbix package could
# be successfully installed as a result of it being available natively on the
# platform it which it was run which results in a false positive for the
# consumer of the cookbook.
#
# The hash key is the codename of the OS/version.  If the hash value evaluates
# to true, the OS/version is considered supported.

default['apt-zabbix']['debian']['supported-codenames'] = {
    wheezy:	true,	# Debian 7.x
    jessie:	true	# Debian 8.x
}
default['apt-zabbix']['release_repo'] = '3.0'

codename = node['lsb']['codename']

default['apt-zabbix']['repos'].tap do |repo|
    repo['zabbix'].tap do |value|
        # Does this cookbook manage the install of the repo?
        value['managed'] = true
        # Set the repo name
        value['repo_name'] = 'zabbix'
        # URI of Repo
        value['uri'] = "http://repo.zabbix.com/zabbix/#{node['apt-zabbix']['release_repo']}/debian"
        # Package distribution of repo
        value['distribution'] = codename
        # Repo Package Groupings
        value['components'] = ['main']
        # Cookbook File For Signing Key
        value['key'] = 'zabbix-official-repo.key'
	# Whether or not to include the repo source repo
	value['deb-src'] = false
    end
end


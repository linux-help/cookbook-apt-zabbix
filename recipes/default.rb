#
# Author:: Eric Renfro (<psi-jack@linux-help.org>)
# Recipe:: apt-zabbix::default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# check if platform is supported
platform_family = node['platform_family']
platform = node['platform']
platform_version = node['platform_version']

fail("#{platform_family}/#{platform}/#{platform_version} is not supported by the default recipe") \
    unless platform_family?('debian') &&
           node['apt-zabbix']['debian']['supported-codenames']
           .select { |_version, is_included| is_included }
           .keys
           .include?(node['lsb']['codename'])

node['apt-zabbix']['repos'].each do |repo, value|
    apt_repository repo do
        # define all attributes even though we are not using them all so that the
        #  values can be passed through to override apt repository definitions

        # Attribute Sources:
        #  https://github.com/opscode-cookbooks/apt
        #  https://github.com/opscode-cookbooks/apt/blob/master/resources/repository.rb

        repo_name value['repo_name'] unless value['repo_name'].nil?
        uri value['uri'] unless value['uri'].nil?
        distribution value['distribution'] unless value['distribution'].nil?
        components value['components'] unless value['components'].nil?
        arch value['arch'] unless value['arch'].nil?
        trusted value['trusted'] unless value['trusted'].nil?
        deb_src value['deb-src'] unless value['deb-src'].nil?
        keyserver value['keyserver'] unless value['keyserver'].nil?
        key value['key'] unless value['key'].nil?
        key_proxy value['key_proxy'] unless value['key_proxy'].nil?
        cookbook value['cookbook'] unless value['cookbook'].nil?
        cache_rebuild value['cache_rebuild'] unless value['cache_rebuild'].nil?
    end if value['managed']
end


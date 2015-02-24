#
# Cookbook Name:: yum-rhn-plugin
# Recipe:: config
#
# Author:: Drew Rapenchuk <rapenchuk@linux.com>
# Copyright 2015, Drew Rapenchuk
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
#
cache_path = Chef::Config['file_cache_path']

template "#{cache_path}/0main.rhn.conf" do
  source 'rhnplugin.conf.erb'
  variables(
    channel: 'main',
    enabled: node['yum-rhn']['main']['enabled'],
    gpg_check: node['yum-rhn']['main']['gpg-check']
  )
  action :create
end

unless node['yum-rhn']['data_bag'].nil?
  data_bag(node['yum-rhn']['data_bag']).each do |value|
    item = data_bag_item(node['yum-rhn']['data_bag'], value)
    template "#{cache_path}/value.rhn.conf" do
      source 'rhnplugin.conf.erb'
      variables(
        channel: item['channel'],
        is_enabled: item['enabled'],
        gpg_check: item['gpg-check']
      )
    end
  end
end

file "/etc/yum/pluginconf.d/rhnplugin.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  action :touch
end

execute "cat #{Chef::Config['file_cache_path']}/*.rhn.conf > /etc/yum/pluginconf.d/rhnplugin.conf" do
end


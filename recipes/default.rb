#
# Cookbook Name:: yum-rhn-plugin
# Recipe:: default
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


unless node['yum-rhn']['source'].nil?
  remote_file "#{Chef::Config[:file_cache_path]}/yum-rhn-plugin.noarch.rpm" do
    source node['yum-rhn']['source']
    action :create
  end
  package 'yum-rhn-plugin' do
    source "#{Chef::Config[:file_cache_path]}/yum-rhn-plugin.noarch.rpm"
    action :install
  end
else
  package 'yum-rhn-plugin' do
    action :install
  end
end

include_recipe 'yum-rhn-plugin::config'

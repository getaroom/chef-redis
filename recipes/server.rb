#
# Cookbook Name::       redis
# Description::         Redis server with runit service
# Recipe::              server
# Author::              Benjamin Black
#
# Copyright 2011, Benjamin Black
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

include_recipe 'runit'
include_recipe 'sysctl'

case node[:redis][:installation_preference]
when "upstream"
  include_recipe "redis::install_from_upstream"
#when "launchpad"
# TODO: Broken, not implemented as it's 2.4.9
#  include_recipe "redis::install_from_launchpad"
else
  include_recipe "redis::install_from_package"
end

group node[:redis][:group] do
  gid node[:redis][:gid]
end

user node[:redis][:user] do
  uid node[:redis][:uid]
  gid node[:redis][:gid]
  password nil
  shell "/bin/false"
  home node[:redis][:data_dir]
  supports :manage_home => false
  action :create
end

%w(data_dir log_dir conf_dir).each do |p|
  directory node[:redis][p] do
    action :create
    recursive true
    owner node[:redis][:user]
    group node[:redis][:user]
    mode 0755
  end
end

master_server, master_port = nil, nil

if node[:redis][:master_server_role]
  master_nodes = search(:node, "(role:#{node[:redis][:master_server_role]} AND chef_environment:#{node.chef_environment})")
  master_node = master_nodes.first unless master_nodes.empty?
  master_server, master_port = master_node['fqdn'], master_node['redis']['server']['port']
end

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server], :master_server => master_server, :master_port => master_port
  notifies      :restart, "service[redis_server]"
end

runit_service "redis_server" do
  options node[:redis]
end

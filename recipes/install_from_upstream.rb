#
# Cookbook Name::       redis
# Description::         Install from upstream
# Recipe::              Install from upstream
# Author::              Scott M. Likens
#
# Copyright 2012, Scott M. Likens
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

redis_server = node[:redis][:bin_location]

directory "#{Chef::Config[:file_cache_path]}/redis/source" do
  action :create
  recursive true
  not_if { File.exists?(redis_server) }
end

directory "#{Chef::Config[:file_cache_path]}/redis/tarball" do
  action :create
  recursive true
  not_if { File.exists?(redis_server) }
end

remote_file "#{Chef::Config[:file_cache_path]}/redis/tarball/redis-#{node[:redis][:version]}" do
  source node[:redis][:release_url]
  not_if { File.exists?(redis_server) }
end

execute "untar redis v:#{node[:redis][:version]}" do
  cwd "#{Chef::Config[:file_cache_path]}/redis/source"
  command "tar zxf #{Chef::Config[:file_cache_path]}/redis/tarball/redis-#{node[:redis][:version]}"
  not_if { File.exists?(redis_server) }
end

execute "make redis v:#{node[:redis][:version]}" do
  cwd "#{Chef::Config[:file_cache_path]}/redis/source/redis-#{node[:redis][:version]}"
  command "make all"
  not_if { File.exists?(redis_server) }
end

execute "install redis v:#{node[:redis][:version]}" do
  cwd "#{Chef::Config[:file_cache_path]}/redis/source/redis-#{node[:redis][:version]}"
  command "make install"
  not_if { File.exists?(redis_server) }
end

directory "#{Chef::Config[:file_cache_path]}/redis/tarball" do
  action :delete
  recursive true
end

directory "#{Chef::Config[:file_cache_path]}/redis/source" do
  action :delete
  recursive true
end

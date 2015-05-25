#
# Cookbook Name:: passenger
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

gem_package "passenger" do
  gem_binary node[:passenger][:gem_binary]
  options    "--no-ri --no-rdoc"
  action     :install
end

execute "passenger_module" do
  command node[:passenger][:install_command_path]
end

ruby_block "set passenger attributes" do
  block do
    node.default[:passenger][:passenger_root] = %x(#{node[:passenger][:passenger_config_command_path]}).chomp
    node.default[:passenger][:passenger_ruby] = %x(source /etc/profile.d/rbenv.sh; rbenv which ruby).chomp
  end
end

template "/opt/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

directory "/opt/nginx/conf.d" do
  action :create
  owner  "root"
  group  "root"
  mode   "0755"
end

template "/etc/init.d/nginx" do
  source "init.d/nginx"
  owner "root"
  group "root"
  mode  "0755"
end

service "nginx" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

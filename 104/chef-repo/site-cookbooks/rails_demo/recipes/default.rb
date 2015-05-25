#
# Cookbook Name:: rails_demo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/var/www/vhost/rails-demo/shared/config" do
  action    :create
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

execute "change owner" do
  command "chown -R op:op /var/www/vhost/rails-demo"
end

template "/var/www/vhost/rails-demo/shared/config/database.yml" do
  owner "op"
  group "op"
end

template "/opt/nginx/conf.d/rails-demo.conf" do
  owner  "root"
  group  "root"
  mode   "0644"
end

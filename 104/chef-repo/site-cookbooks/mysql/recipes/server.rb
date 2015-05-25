#
# Cookbook Name:: mysql
# Recipe:: server
#

package "mysql-server" do
  action :install
end

service "mysqld" do
  supports status: true, restart: true
  action [:enable, :start]
end

template "/etc/my.cnf" do
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[mysqld]"
end

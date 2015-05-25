#
# Cookbook Name:: setup_package
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "yum update" do
  action  :run
  user    "root"
  command "yum -y update"
end

package "git" do
  action  :install
end

# necessary to compile Ruby
%w(openssl-devel readline-devel zlib-devel libffi-devel).each do |package_name|
  package package_name do
    action :install
  end
end

# necessary to compile Ruby
%w(gcc-c++ gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel).each do |package_name|
  package package_name do
    action :install
  end
end

# necessary to compile gems
%w(libcurl-devel libxslt-devel libxml2-devel).each do |package_name|
  package package_name do
    action :install
  end
end

# sqlite
%w(sqlite sqlite-devel).each do |package_name|
  package package_name do
    action :install
  end
end

# javascript runtime
package "nodejs" do
  action  :install
end

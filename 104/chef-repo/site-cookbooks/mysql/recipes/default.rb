#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(mysql mysql-devel).each do |package_name|
  package package_name do
    action :install
  end
end

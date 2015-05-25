#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rbenv_root = "/usr/local/rbenv"

group "rbenv" do
  action :create
  append true
end

git rbenv_root do
  action     :checkout
  repository "git://github.com/sstephenson/rbenv.git"
  reference  "master"
  user       "root"
  group      "rbenv"
end

template "/etc/profile.d/rbenv.sh" do
  owner "root"
  group "root"
  mode  "0644"
end

%w(shims versions plugins).each do |dir|
  directory "#{rbenv_root}/#{dir}" do
    action :create
    owner  "root"
    group  "rbenv"
    mode   "0755"
  end
end

git "#{rbenv_root}/plugins/ruby-build" do
  action     :checkout
  repository "git://github.com/sstephenson/ruby-build.git"
  reference  "master"
  user       "root"
  group      "rbenv"
end

git "#{rbenv_root}/plugins/rbenv-default-gems" do
  action     :checkout
  repository "git://github.com/sstephenson/rbenv-default-gems.git"
  reference  "master"
  user       "root"
  group      "rbenv"
end

template "#{rbenv_root}/default-gems" do
  owner "root"
  group "rbenv"
end

bash "chmod #{rbenv_root}" do
  user       "root"
  cwd        rbenv_root
  code       <<-EOH
    chgrp -R rbenv '#{rbenv_root}'
    chmod -R g+rwxXs '#{rbenv_root}'
  EOH
  not_if     { File.stat(rbenv_root).mode.to_s(8) == "42775" }
end

#
# Cookbook Name:: rbenv
# Recipe:: install_ruby
#

rbenv_root = "/usr/local/rbenv"
rbenv_script = "/etc/profile.d/rbenv.sh"

node[:rbenv][:ruby_versions].each do |ruby_version|
  execute "install ruby #{ruby_version}" do
    action  :run
    command "source #{rbenv_script}; rbenv install #{ruby_version}"
    not_if  "source #{rbenv_script}; rbenv versions | grep #{ruby_version}"
  end
end

execute "set global ruby #{node[:rbenv][:global]}" do
  action  :run
  command "source #{rbenv_script}; rbenv global #{node[:rbenv][:global]}; rbenv rehash"
  not_if  "source #{rbenv_script}; rbenv global | grep '#{node[:rbenv][:global]}'"
end

directory rbenv_root do
  recursive true
  owner "root"
  group "rbenv"
end

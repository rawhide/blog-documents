# passenger インストール時に使用する gem のバイナリ
default[:passenger][:gem_binary] = '/usr/local/rbenv/shims/gem'

default[:passenger][:install_command_path] = '/usr/local/rbenv/shims/passenger-install-nginx-module --auto --auto-download'
default[:passenger][:passenger_config_command_path] = '/usr/local/rbenv/shims/passenger-config --root'

default[:passenger][:listen] = 80
default[:passenger][:server_name] = 'example.com'

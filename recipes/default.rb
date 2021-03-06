#
# Cookbook Name:: chef-msttcorefonts
# Recipe:: default
#

#---------------
# install msttcorefonts
#---------------
case node['platform']
when 'centos', 'redhat', 'scientific', 'fedora'
  include_recipe 'chef-msttcorefonts::rhel'
when 'ubuntu'
  include_recipe 'chef-msttcorefonts::debian'
end

#---------------
# regenerate font cache
#---------------
execute 'regenerate fontcache' do
  command 'fc-cache -fv >/dev/null'
  action :nothing
end

#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node.role?("#{node['web_server_type']['apache']}")
  include_recipe 'web_apache'
elsif node.role?("#{node['web_server_type']['nginx']}")
  include_recipe 'web_nginx'
end


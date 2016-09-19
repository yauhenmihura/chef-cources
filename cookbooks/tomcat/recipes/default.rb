#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install tomcat with yum
package 'tomcat' do
	action :install
end

# Install tomcat-webapps with yum
package 'tomcat-webapps' do
	action :install
end

# Change server config
template "/etc/tomcat/server.xml" do
	source "server_cfg.erb"
	mode '0755'
	variables ({
	'tomcat_port' => node['tomcat']['port']
	})
end

# Start tomcat
service 'tomcat' do
supports :restart => true, :status => true, :stop => true, :start => true
action :start
end

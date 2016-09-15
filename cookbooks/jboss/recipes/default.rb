#
## Cookbook Name:: jboss7
## Recipe:: default
## Copyright (C) 2014 Andrew DuFour
#
##

include_recipe 'java'

# Install unzip
package 'unzip' do
	package_name 'unzip'
	action :install
end

# Create JBoss User
user node['jboss6']['jboss_user'] do
	action :create
end

# Add  JBoss User to jboss group
group node['jboss6']['jboss_group'] do
	action :create
	members node[:jboss6][:jboss_user]
end

# Download jboss
remote_file "#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_name]}" do
	source node[:jboss6][:package_url]
	owner 'root'
  	group 'root'
	mode 0755
	action :create
	not_if { ::File.file?("#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_name]}")}
end

# Install jboss
execute 'jboss_unzip' do
	user 'root'
	command "unzip -o #{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_name]} -d #{node[:jboss6][:install_path]}"
	action :run
	not_if { ::File.directory?("#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}")}
end

# Download application
remote_file "#{node[:jboss6][:st_app]}/#{node[:jboss6][:app_name]}" do
	source node[:jboss6][:app_url]
	owner 'root'
	group 'root'
	mode 0755
	action :create
	not_if { ::File.file?("#{node[:jboss6][:st_app]}/#{node[:jboss6][:app_name]}")}
end

# Deploy application
execute 'app_deploy' do
	user 'root'
	command "unzip -o /opt/jboss-as-distribution-6.1.0.Final.zip -d /opt"
	action :run
	not_if { ::File.directory?("#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}/server/default/deploy/testweb")}
end


remote_file "#{node[:jboss6][:st_app]}/#{node[:jboss6][:app_name]}" do
       source node[:jboss6][:app_url]
       owner 'root'
       group 'root'
       mode 0755
       action :create
       not_if { ::File.file?("#{node[:jboss6][:st_app]}/#{node[:jboss6][:app_name]}")}
end

execute 'app_deploy' do
       user 'root'
       command "unzip -o #{node[:jboss6][:st_app]}/#{node[:jboss6][:app_name]} -d #{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}/server/default/deploy"
       action :run
       not_if { ::File.directory?("#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}/server/default/deploy/#{node[:jboss6][:app_folder]}")}
end


template "#{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}/server/default/deploy/#{node[:jboss6][:app_folder]}/hudson.xml" do
	source "hudson.erb"
	mode "0755"
	owner "jboss"
	group "jboss"
	variables({
	  :engine => data_bag_item('databag', 'hudson')['engine']
	})
end

# Set chown as jboss user 
execute 'jboss_chown' do
	user 'root'
	command "chown -R #{node[:jboss6][:jboss_user]}:#{node[:jboss6][:jboss_group]} #{node[:jboss6][:install_path]}/#{node[:jboss6][:jb_folder]}"
	action :run
end

# Init script
template '/etc/init.d/jboss' do
	source "jboss_init.erb"
	mode 0775
	owner 'root'
	group 'root'
	variables({
          'user' => node['jboss6']['jboss_user'],
          'jboss_home' => node['jboss6']['jboss_path']
  })
end

# Start jboss
service "jboss" do
	supports :restart => true, :start => true, :stop => true
	action [ :enable, :start ]
end

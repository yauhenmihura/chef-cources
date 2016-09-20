#
# Cookbook Name:: jenkins
# Recipe:: default
#

# Install unzip and git
package 'unzip' do
	package_name 'unzip'
	action :install
end

package 'git' do
	package_name 'git'
	action :install
end

# Install jenkins repo and key
yum_repository "jenkins" do
  	baseurl "http://pkg.jenkins-ci.org/redhat"
  	gpgkey "https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  	action :create
end

# Install jenkins from yum
package 'jenkins' do 
  	package_name 'jenkins'
  	action :install
end

# Copy jenkins config
template "/etc/sysconfig/jenkins" do
  	source "jenkins_cfg.erb"
  	mode "0644"
  	owner "root"
  	group "root"
  	variables({
    	  'jenkins_port' => node['jenkins']['port'],
    	  'jenkins_prefix' => node['jenkins']['prefix']
	})
end

# Copy jobs, plugins, configs to jenkins directory
remote_directory "/var/lib/jenkins" do
  	source 'jenkins'
  	owner 'jenkins'
  	group 'jenkins'
    	mode 0755
  	action :create
end

# Chown jenkins folder
execute 'jenkins dir chown' do
	command "chown -R jenkins:jenkins /var/lib/jenkins"
end

# Add jenkins user into sudoers
template "/etc/sudoers.d/jenkins" do
	source "jenkins_user.erb"
 	mode "0644"
	owner "root"
  	group "root"
end

# Start service jenkins
service 'jenkins' do
	supports [:stop, :start, :restart]
	action [:start, :enable]
end

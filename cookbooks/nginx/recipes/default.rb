
# Install nginx with yum
package 'nginx' do
  action :install
end

# Change nginx default cfg
template "/etc/nginx/conf.d/default.conf" do
  source "nginx_cfg.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    'nginx_port' => node['nginx']['nginx_port'],
    'jenkins_port' => node['nginx']['jenkins_port'],
    'tomcat_port' => node['nginx']['tomcat_port']
  })
end

# Start nginx
service "nginx" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

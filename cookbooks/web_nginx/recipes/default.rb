#
# Cookbook Name:: web_nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

web "install nginx" do
  action :install_server
  provider "web_nginx"
end

web "start nginx" do
  action :start
  provider "web_nginx"
end

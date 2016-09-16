#
# Cookbook Name:: web_apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

web "install apache" do
  action :install_server
  provider "web_apache"
end

web "start apache" do
  action :start
  provider "web_apache"
end


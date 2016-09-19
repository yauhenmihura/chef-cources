#
# Install java 1.7.0 

yum_package 'java-1.7.0-openjdk-devel.x86_64' do
  action :install
end

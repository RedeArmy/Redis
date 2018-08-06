# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2018, Eder Garcia, Apache 2.0.

# Add redis repository
apt_repository 'redis-server' do
  uri          'ppa:chris-lea/redis-server'
end

# Update OS repositories
execute "update" do
  command "apt-get update"
  action :run
end

# Install redis-server
package 'redis-server'

# Cookbook:: redis
# Recipe:: slave
#
# Copyright:: 2018, Eder Garcia, Apache 2.0.

#Parameters
instance = search("aws_opsworks_instance", "hostname:RedisMasterInstance").first

node.default[:redis][:master_server] = "#{instance['private_ip']}"
node.default[:redis][:slave] = "yes"

directory node[:redis][:log_dir] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory node[:redis][:data_dir] do
  owner 'redis'
  group 'redis'
  mode '0755'
  action :create
end

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end

execute 'redis-server' do
  command "redis-server #{node[:redis][:conf_dir]}/redis.conf"
  user 'root'
end

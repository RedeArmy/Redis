# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2018, Eder Garcia, Apache 2.0.

# Configure master node template
template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end

execute 'redis-server-master' do
  command "redis-server #{node[:redis][:conf_dir]}/redis.conf"
  user 'root'
end

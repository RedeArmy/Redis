# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2018, Eder Garcia, Apache 2.0.

# Install redis_sentinel
package 'redis-sentinel'

master = search("aws_opsworks_instance", "hostname:masterhost").first
slavea = search("aws_opsworks_instance", "hostname:slave1").first
slaveb = search("aws_opsworks_instance", "hostname:slave2").first
slavec = search("aws_opsworks_instance", "hostname:slave3").first

sentinel_port = 0
template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :master_ip => "#{master['private_ip']}", :slave_ip_a => "#{slavea['private_ip']}", :slave_ip_b => "#{slaveb['private_ip']}", :slave_ip_c => "#{slavec['private_ip']}"
end



execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end

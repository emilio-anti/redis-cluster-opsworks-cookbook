# install redis
package 'redis-server' do
  action :install
end

instance = search('aws_opsworks_instance', 'hostname:redis-master1').first
Chef::Log.info("********** Searching for master IP: #{instance['public_ip']} **********")

node.default['opsworks-redis-cluster']['master-ip'] = "#{instance['public_ip']}"

template '/etc/redis/redis.conf' do
  source 'redis.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[redis-server]'
end

# enable=ing and starting the service
service 'redis-server' do
  action [:enable, :start]
end

link '/usr/bin/redis-sentinel' do
  to '/usr/bin/redis-server'
end

cookbook_file '/etc/init.d/redis-sentinel' do
  source 'redis-sentinel'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/redis/sentinel.conf' do
  source 'sentinel.conf.erb'
  owner 'redis'
  group 'redis'
  mode '0644'
end

service 'redis-sentinel' do
  action [:enable, :start]
end

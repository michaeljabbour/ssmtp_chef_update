require 'pp'
#
# Cookbook Name:: ssmtp
# Recipe:: default
#

if ['solo', 'app', 'util', 'app_master'].include?(node[:instance_role])

  directory '/etc/ssmtp' do
    recursive true
    action :delete
  end

  directory '/data/ssmtp' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    not_if 'test -d /data/ssmtp'
  end

  link '/etc/ssmtp' do
    to '/data/ssmtp'
  end
  
if ['development', 'test'].include?(node[:environment][:name])
    template '/data/ssmtp/ssmtp.conf' do
    source 'ssmtp.conf.erb'
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
      :root => 'postmaster',
      :mailhub => '[smtp.yourdomain.com:port]',
      :rewritedomain => '[your domain]',
      :fromlineoverride => 'YES',
      :usestarttls => 'YES',
      :authuser => '[your username]',
      :authpass => '[your password]',
      :authmethodlogin => 'LOGIN'
    })
  end
end


if node[:environment][:name] == 'staging'
    template '/data/ssmtp/ssmtp.conf' do
    source 'ssmtp.conf.erb'
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
      :root => 'postmaster',
      :mailhub => '[smtp.yourdomain.com:port]',
      :rewritedomain => '[your domain]',
      :fromlineoverride => 'YES',
      :usestarttls => 'YES',
      :authuser => '[your username]',
      :authpass => '[your password]',
      :authmethodlogin => 'LOGIN'
    })
  end
end

  
if node[:environment][:name] == 'production'
    template '/data/ssmtp/ssmtp.conf' do
    source 'ssmtp.conf.erb'
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
      :root => 'postmaster',
      :mailhub => '[smtp.yourdomain.com:port]',
      :rewritedomain => '[your domain]',
      :fromlineoverride => 'YES',
      :usestarttls => 'YES',
      :authuser => '[your username]',
      :authpass => '[your password]',
      :authmethodlogin => 'LOGIN'
    })
  end
end
 
end
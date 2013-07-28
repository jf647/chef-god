package "logrotate"

# create directories for God
[ "#{node[:god][:config_dir]}", "#{node[:god][:config_dir]}/services-enabled", "#{node[:god][:config_dir]}/services-available" ].each do |dir|
    directory dir do
        owner "root"
        group "root"
        mode 0755    
    end
end

# main God config
template "#{node[:god][:config_dir]}/god.rb" do
    source "god.config.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
        :enabled_services_dir => "#{node[:god][:config_dir]}/services-enabled",
    )
end

# logrotate config
template "/etc/logrotate.d/god" do
    source "god.logrotate.erb"
    owner "root"
    group "root"
    mode 0644
end

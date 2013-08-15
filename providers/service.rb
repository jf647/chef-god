require 'chef/mixin/command'
require 'chef/mixin/language'

include Chef::Mixin::Command

action :load do
    execute "#{@god_bin} load #{@config_path}" do
        only_if @god_running
    end
end

action :remove do
    execute "#{@god_bin} remove #{@config_path}" do
        only_if @god_running
    end
end

action :start do
    execute "#{@god_bin} start #{@new_resource.service_name}" do
        only_if @god_running
    end
end

action :stop do
    execute "#{@god_bin} stop #{@new_resource.service_name}" do
        only_if @god_running
    end
end

action :restart do
    execute "#{@god_bin} restart #{@new_resource.service_name}" do
        only_if @god_running
    end
end

def load_current_resource
    @service = Chef::Resource::GodService.new(new_resource.service_name)
    @config_path = "#{node[:god][:config_dir]}/services-enabled/#{new_resource.service_name}.god"
    @god_bin = "#{node[:cligem][:install_dir]['god']}/bin/god"
    
    begin
        if 0 == run_command_with_systems_locale( :command => "#{@god_bin} status" )
            @god_running = true
        end
    rescue Chef::Exceptions::Exec
    end
end

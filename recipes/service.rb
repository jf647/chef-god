# init script
case node[:god][:init_style]

    when "upstart"

        upstart_job_dir = "/etc/init"
        upstart_job_suffix = ".conf"

        template "#{upstart_job_dir}/god#{upstart_job_suffix}" do
            source "god.upstart.erb"
            owner "root"
            group "root"
            mode 0644
            variables(
                :god_path => "#{node[:cligem][:install_dir]['god']}/bin/god",
            )
            notifies :restart, "service[god]", :delayed
        end

        service "god" do
            provider Chef::Provider::Service::Upstart
            action [:enable,:start]
        end

    else

        log "Could not determine service init style, manual intervention required to start up the god service."

end

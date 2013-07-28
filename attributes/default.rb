default[:god][:config_dir] = '/etc/god'
default[:god][:log_dir] = '/var/log'
default[:god][:pid_dir] = '/var/run'
default[:god][:version] = '"~> 0.13.2"'

case node['platform_family']
when "debian"
  case node['platform']
    when "ubuntu"
      default[:god][:init_style]  = "upstart"
    else
      default[:god][:init_style]  = "init"
  end
when "rhel","fedora","suse"
  default[:god][:init_style]  = "init"
when "solaris2"
  default[:god][:init_style]  = "smf"
else
  default[:god][:init_style]  = "none"
end

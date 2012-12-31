#
# Locations
#

default[:redis][:conf_dir]          = "/etc/redis"
default[:redis][:log_dir]           = "/var/log/redis"
default[:redis][:data_dir]          = "/var/lib/redis"
default[:redis][:bin_location]      = "/usr/local/bin/redis-server"

default[:redis][:home_dir]          = "/usr/local/share/redis"
default[:redis][:pid_file]          = "/var/run/redis.pid"

default[:redis][:db_basename]       = "dump.rdb"

default[:redis][:user]              = 'redis'
default[:redis][:group]             = 'redis'
default[:redis][:uid]               = 335
default[:redis][:gid]               = 335

#
# Server
#

default[:redis][:server][:addr]     = "0.0.0.0"
default[:redis][:server][:port]     = "6379"

#
# Install
#

default[:redis][:installation_preference] = "upstream"
default[:redis][:version]           = "2.4.13"
default[:redis][:release_url]       = "http://redis.googlecode.com/files/redis-#{node[:redis][:version]}.tar.gz"

#
# Tunables
#

default[:sysctl][:vm][:overcommit_memory] = 1 if node[:memory][:total].to_i > 8169948
default[:redis][:maxmemory] = nil

default[:redis][:server][:timeout]  = "300000"
default[:redis][:server][:max_open_files] = 4096 # exceeding this value will require figuring out how to change the hard limit
default[:redis][:glueoutputbuf]     = "yes"

default[:redis][:saves]             = [["3600", "1"]]
default[:redis][:shareobjects]      = "no"
if (node[:redis][:shareobjects] == "yes")
  default[:redis][:shareobjectspoolsize] = 1024
end

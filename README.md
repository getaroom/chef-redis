# redis chef cookbook

Redis: a fast, flexible datastore offering an extremely useful set of data structure primitives

## Overview

Redis, a fast lightweight database

## Recipes 

* `client`                   - Client support for Redis database
* `default`                  - Base configuration for redis
* `install_from_package`     - Install From Ubuntu Package -- easy but lags in version
* `install_from_release`     - Install From Release
* `server`                   - Redis server with runit service

## Integration

Supports platforms: debian and ubuntu

Cookbook dependencies:
* runit

## Revisions

- 3.0.7 - Release brought in 
- 3.0.8 - Enabled vm.overcommit_memory=1 and ensured it did not overlap
- 3.0.9 - Added server_small that doesn't use vm.overcommit_memory so it can be safe for usage with Resque.
- 3.0.10 - bumped to 2.4.9
- 4.0.0.0 - Removed dependencies of metachef and install_from_source.  

## Bugs

* `[:redis][:version]` does not rebuild the version string in `[:redis][:release_url]`.  In order to update Redis you must update the release_url with the version included in the string.  Such as "http://redis.googlecode.com/files/redis-2.4.13.tar.gz"

## Attributes

* `[:redis][:home_dir]`               -  (default: "/usr/local/share/redis")
* `[:redis][:pid_file]`               - Redis PID file path (default: "/var/run/redis.pid")
  - Path to the PID file when daemonized.
* `[:redis][:log_dir]`                - Redis log dir path (default: "/var/log/redis")
  - Path to the log directory when daemonized -- will be stored in [log_dir]/redis.log.
* `[:redis][:data_dir]`               - Redis database directory (default: "/var/lib/redis")
  - Path to the directory for database files.
* `[:redis][:db_basename]`            - Redis database filename (default: "dump.rdb")
  - Filename for the database storage.
* `[:redis][:release_url]`            - URL for redis release package (default: "http://redis.googlecode.com/files/redis-:version:.tar.gz")
  - If using the install_from_release strategy, the URL for the release tarball
* `[:redis][:glueoutputbuf]`          - Redis output buffer coalescing (default: "yes")
  - Glue small output buffers together into larger TCP packets.
* `[:redis][:saves]`                  - Redis disk persistence policies
  - An array of arrays of time, changed objects policies for persisting data to disk.
* `[:redis][:slave]`                  - Redis replication slave (default: "no")
  - Act as a replication slave to a master redis database.
* `[:redis][:shareobjects]`           - Redis shared object compression (default: "no") (default: "no")
  - Attempt to reduce memory use by sharing storage for substrings.
* `[:redis][:conf_dir]`               -  (default: "/etc/redis")
* `[:redis][:user]`                   -  (default: "redis")
* `[:redis][:version]`                -  (default: "2.0.2")
* `[:redis][:server][:addr]`          - IP address to bind. (default: "0.0.0.0")
* `[:redis][:server][:port]`          - Redis server port (default: "6379")
  - TCP port to bind.
* `[:redis][:server][:timeout]`       - Redis server timeout (default: "300")
  - Timeout, in seconds, for disconnection of idle clients.
* `[:users][:redis][:uid]`            -  (default: "335")
* `[:groups][:redis][:gid]`           -  (default: "335")

## License and Author

Author::                Scott M. Likens (<scott@likens.us>)
Copyright::             2012, Scott M. Likens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

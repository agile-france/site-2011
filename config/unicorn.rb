# http://unicorn.bogomips.org/examples/unicorn.conf.rb
#
# unicorn_rails -c config/unicorn.rb -E production -D
app_root = File.expand_path "../..", __FILE__

# 4 workers and 1 master
worker_processes 4

# Load rails  into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Listen on a both unix socket and 3000
listen "#{app_root}/tmp/sockets/unicorn.sock"
listen 3000, tcp_nopush: true

# pid
pid "#{app_root}/tmp/pids/unicorn.pid"

# paths
app_name = "qiita_clone_2019"
app_path = "/var/www/#{app_name}"
listen_path = "#{app_path}/tmp/sockets/unicorn.sock"
shared_path = "/var/www/#{app_name}/shared"
current_path = "/var/www/#{app_name}/current/"

# unicorn paths
working_directory current_path
pid "#{shared_path}/tmp/pids/unicorn.pid"

# listen
listen listen_path, backlog: 64

# logging
stderr_path "#{current_path}/log/unicorn.stderr.log"
stdout_path "#{current_path}/log/unicorn.stdout.log"

# workers
worker_processes 2

# Time-out
timeout 30

# use correct Gemfile on restarts
before_exec do |_server|
  ENV["BUNDLE_GEMFILE"] = "#{current_path} Gemfile"
end

# preload
preload_app true

before_fork do |server, _worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  # rubocop: disable Lint/HandleExceptions
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
  # rubocop: enable Lint/HandleExceptions
end

after_fork do |_server, _worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

rails_env = ENV['RAILS_ENV'] || 'production'
# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = "/u/apps/unicorn-sinatra-mongo/current/"

worker_processes 3
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "#{@dir}tmp/sockets/unicorn.sock", :backlog => 64

# Set process id path
pid "#{@dir}tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"

preload_app true

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "/u/apps/unicorn-sinatra-mongo/current/Gemfile"
end

before_fork do |server, worker|
  # Disconnect since the database connection will not carry over
  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end

  # Quit the old rainbows process
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  if defined?(Resque)
    Resque.redis.quit
  end

  sleep 1
end

after_fork do |server, worker|
  # Start up the database connection again in the worker
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = 'localhost:6379'
  end
end
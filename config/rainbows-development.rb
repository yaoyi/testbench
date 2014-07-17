worker_processes 3
#Rainbows! do
#  use :ThreadPool
#  # use :ThreadSpawn
#  # worker_connections 10
#  worker_connections 1
#end
timeout 30

preload_app true


before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "../Gemfile"
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

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'puma-sinatra-mongo'
set :repo_url, 'https://github.com/yaoyi/testbench.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'puma-sinatra-mongo'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/u/apps/puma-sinatra-mongo'

# Default value for :scm is :git
# set :scm, :git

# Use agent forwarding for SSH so you can deploy with the SSH key on your workstation.
set :ssh_options, {
  forward_agent: true
}

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/thin/production.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: "/opt/rbenv/shims:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{current_path}/tmp/pids/puma.state"
set :puma_pid, "#{current_path}/tmp/pids/puma.pid"
set :puma_bind, [ "unix://#{current_path}/tmp/sockets/puma0.sock", "unix://#{current_path}/tmp/sockets/puma1.sock", "unix://#{current_path}/tmp/sockets/puma2.sock" ]
# set :puma_conf, "#{current_path}/config/puma.rb"
set :puma_access_log, "#{current_path}/log/puma_error.log"
set :puma_error_log, "#{current_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [8, 32]
set :puma_workers, 3
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true

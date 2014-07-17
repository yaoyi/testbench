# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'intercity_sample_app'
set :repo_url, 'https://github.com/yaoyi/testbench.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, ENV['rev'] || 'master'
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/u/apps/intercity_sample_app'

# Default value for :scm is :git
# set :scm, :git

# Use agent forwarding for SSH so you can deploy with the SSH key on your workstation.
set :ssh_options, {
  forward_agent: true,
  keys: ['~/.vagrant.d/insecure_private_key']
}

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

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

set :nginx_server_name, "192.168.33.10"
set :rainbows_user, "vagrant"
set :rainbows_workers, 3
set :rainbows_service_name, "rainbows"
set :nginx_config_name, "#{fetch(:application)}.conf"
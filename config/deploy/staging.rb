# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{deploy@puma-sinatra-mongo.testbench.staging-1.foodspy.io}
role :web, %w{deploy@puma-sinatra-mongo.testbench.staging-1.foodspy.io}
role :db,  %w{deploy@puma-sinatra-mongo.testbench.staging-1.foodspy.io}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'puma-sinatra-mongo.testbench.staging-1.foodspy.io', user: 'deploy', roles: %w{web app db}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{current_path}/tmp/pids/puma.state"
set :puma_pid, "#{current_path}/tmp/pids/puma.pid"
set :puma_bind, [ "unix://#{current_path}/tmp/sockets/puma0.sock", "unix://#{current_path}/tmp/sockets/puma1.sock", "unix://#{current_path}/tmp/sockets/puma2.sock" ]
# set :puma_conf, "#{current_path}/config/puma.rb"
set :puma_access_log, "#{current_path}/log/puma_error.log"
set :puma_error_log, "#{current_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'staging'))
set :puma_workers, 3
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
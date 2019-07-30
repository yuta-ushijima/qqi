set :stage, "production"
set :branch, ENV["BRANCH"] || "master"
# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# For API
server "3.113.242.122", user: "ec2-user", roles: %w[apgp db web]

set :unicorn_pid, "/var/www/#{fetch(:application)}/shared/tmp/pids/unicorn.pid"
set :unicorn_rack_env, "production"
set :unicorn_config_path, "/var/www/#{fetch(:application)}/current/config/unicorn/production.rb"
set :rails_env, "production"
set :bundle_clean_options, "--clean"
set :bundle_without, %w[development test].join(" ")
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# For New Encrypted Credentials of Rails5++
# ==================
set :linked_files, %w[config/master.key config/database.yml]
# set :linked_files, fetch(:linked_files, []).push("config/database.yml")
# set :linked_files, fetch(:linked_files, []).push("config/master.key")
#

# before "deploy:starting", "deploy:upload"

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
set :ssh_options, {
  port: 22,
  keys: %w[~/.ssh/yuta-ushijima.pem],
  forward_agent: true,
  auth_methods: %w[publickey],
  # proxy: Net::SSH::Proxy::Command.new("ssh qiita_clone_2019_ec2 -W %h:%p"),
}
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
#

namespace :deploy do
  desc "Upload database.yml"
  task :upload do
    on roles([:app, :delayedjob, :sidekiq]) do |_host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!("config/database.yml", "#{shared_path}/config/database.yml")
      upload!("config/master.key", "#{shared_path}/config/master.key")
    end
  end
end

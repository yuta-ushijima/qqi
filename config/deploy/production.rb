set :stage, "production"
set :branch, ENV["BRANCH"] || "master"

server "3.113.242.122", user: "ec2-user", roles: %w[apgp db web]
server "example.com", user: "deploy", roles: %w[app web], other_property: :other_value

# Global options
# --------------
set :ssh_options, {
  port: 22,
  keys: %w[~/.ssh/yuta-ushijima.pem],
  forward_agent: true,
  auth_methods: %w[publickey],
  # proxy: Net::SSH::Proxy::Command.new("ssh qiita_clone_2019_ec2 -W %h:%p"),
}

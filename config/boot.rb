ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# This code refs: https://github.com/Shopify/bootsnap/issues/77#issuecomment-443581752
# Gather environment information
# in_console = (ARGV & ['c', 'console']).any?
# in_development = ENV['RAILS_ENV'] != 'production'

# Do not use bootsnap in production console to prevent cache file permission issues
# if in_development || !in_console
#   require 'bootsnap/setup'
# end

# config/boot.rb
require 'logger'            # <= add this line first

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup'     # Set up gems listed in the Gemfile.
# require 'bootsnap/setup'  # If you use bootsnap, leave it; it’s fine after 'logger'
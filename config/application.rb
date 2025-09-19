# config/application.rb
require 'logger'                     # keep this at the top (from earlier fix)
require_relative 'boot'

require 'rails'                      # instead of 'rails/all'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'          # keep if you use the asset pipeline
# require 'active_storage/engine'    # <-- leave this commented out
# require 'action_cable/engine'      # add if you use Action Cable

Bundler.require(*Rails.groups)

module BoFRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :options]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

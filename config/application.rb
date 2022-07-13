require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JobBoard
  class Application < Rails::Application    

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => :any
      end
    end

    #autoloads lib folder during production
    config.eager_load_paths << Rails.root.join('lib')

    #autoloads lib folder during development
    config.autoload_paths << Rails.root.join('lib')
    config.load_defaults 7.0
    config.api_only = true
  end
end

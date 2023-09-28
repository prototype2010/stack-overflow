require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StackOverflow
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.action_view.form_with_generates_remote_forms = true
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths << "#{root}/app/services"
    # config.time_zone = "Central Time (US & Canada)"
    config.generators do |g|
      g.test_framework :rspec,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
    end
  end
end

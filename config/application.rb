require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PayrollCalculatorApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = "America/Santiago"
  end
end

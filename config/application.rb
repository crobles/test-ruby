require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PayrollCalculatorApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = "America/Santiago"
    config.active_support.to_time_preserves_timezone = :zone
  end
end

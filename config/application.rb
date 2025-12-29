require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Stockiov2
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    config.solid_cache.enabled = false
    config.active_record.cache_versioning = false
  end
end

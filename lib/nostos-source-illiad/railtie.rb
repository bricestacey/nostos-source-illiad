require 'rails'

module Source
  module Illiad
    class Railtie < Rails::Railtie
      config.source_illiad = ActiveSupport::OrderedOptions.new

      
      initializer "source_illiad.configure" do |app|
        config_file = File.join(Rails.root, 'config', 'source_illiad.yml')

        # Only run configuration if config/source_illiad.yml exists
        if File.exists?(config_file)
          CONFIG = YAML::load(File.open(config_file))
          Source::Illiad.configure do |config|
            config.number_of_days_to_poll = CONFIG["number_of_days_to_poll"]
            config.db = CONFIG["db"]
            config.webcirc = CONFIG["webcirc"]
          end

          ::Illiad::AR::Base.establish_connection(Source::Illiad.config.db)
        end
      end
    end
  end
end

require 'rails'

module Source
  module Illiad
    class Railtie < Rails::Railtie
      config.source_illiad = ActiveSupport::OrderedOptions.new

      initializer "source_illiad.configure" do |app|
        Source::Illiad.configure do |config|
          config.number_of_days_to_poll = app.config.source_illiad[:number_of_days_to_poll]
          config.db = app.config.source_illiad[:db]
          config.webcirc = app.config.source_illiad[:webcirc]
        end
      end

      initializer "source_illiad.establish_connection", :after => "source_illiad.configure" do |app|
        IlliadAR::AR::Base.establish_connection(Source::Illiad.config.db)
      end
    end
  end
end

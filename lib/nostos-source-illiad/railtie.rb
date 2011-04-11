require 'rails'
require 'activerecord-illiad-adapter'

module Source
  module Illiad
    class Railtie < Rails::Railtie
      config.source_illiad = ActiveSupport::OrderedOptions.new

      initializer "source_illiad.configure" do |app|
        Source::Illiad.configure do |config|
          config.number_of_days_to_poll = app.config.source_illiad[:number_of_days_to_poll]
          config.db = app.config.source_illiad[:db]
        end
      end

      initializer "source_illiad.establish_connection", :after => "source_illiad.configure" do |app|
        IlliadAR::Base.establish_connection(Source::Illiad.config.db)
      end
    end
  end
end

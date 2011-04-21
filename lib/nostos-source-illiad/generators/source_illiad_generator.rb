require 'rails/generators'

module SourceIlliad
  class InstallGenerator < Rails::Generators::Base
    def configure
      # Ask General Questions
      puts "General Configuration:"
      number_of_days_to_poll = ask('How many days in the past would you like to poll Illiad? [7]')
      number_of_days_to_poll = 7 if number_of_days_to_poll.blank?

      # Ask DB Questions
      puts "Database Configuration:"
      puts "The following fields are required to establish a connection with your Illiad server."
      db = {}
      db[:dataserver] = ask('dataserver (the name for your server as defined in freetds.conf): ')
      db[:username] = ask('username (the database server user): ')
      db[:password] = ask('password (the user password): ')

      # Ask WebCirc Questions
      puts "WebCirc Configuration:"
      webcirc = {}
      webcirc[:url] = ask('URL: ')
      webcirc[:username] = ask('Username: ')
      webcirc[:password] = ask('Password: ')

      # Configure application settings
      create_file File.join(Rails.root, 'config', 'source_illiad.yml'), <<CONFIG
# Source Illiad Configuration

# This is the number of days into the past you would like to poll. 
# This value must be greater than how often you run your daily cron job.
number_of_days_to_poll: #{number_of_days_to_poll}

# Database
db:
  adapter:    'sqlserver'
  dataserver: '#{db[:dataserver]}'
  username:   '#{db[:username]}'
  password:   '#{db[:password]}'

# Web Circulation
webcirc:
  url:      '#{webcirc[:url]}'
  username: '#{webcirc[:username]}'
  password: '#{webcirc[:password]}'
CONFIG

    end
  end
end

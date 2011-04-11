# Nostos Source Driver: Illiad

This is an Illiad source driver for Nostos.

See [Nostos](https://github.com/bricestacey/nostos) for more information.

## Installation

Add the following to your Gemfile and run `bundle install`

    gem 'nostos-source-illiad'

## Configuration

In `config/application.rb` add the following options:

    config.source_illiad.number_of_days_to_poll = 2
    config.source_illiad.db = {
      :dataserver => '',
      :adapter => 'sqlserver',
      :host => '',
      :dsn => '',
      :username => '',
      :password => '',
      :database => ''
    }

`dataserver` is the name for your server as defined in freetds.conf. `number_of_days_to_poll` is how many days you want to poll into the past. This number must be greater than how often you run Nostos in order to stay synchronized. I recommend polling 2-3 days in the past at most.

# Author

Nostos was written by [Brice Stacey](https://github.com/bricestacey)

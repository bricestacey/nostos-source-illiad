# Nostos Source Driver: Illiad

This is an Illiad source driver for Nostos.

See [Nostos](https://github.com/bricestacey/nostos) for more information.

## Installation

Add the following to your Gemfile and run `bundle install`

    gem 'nostos-source-illiad'

## Configuration

You can interactively configure the Illiad source driver by running `rails generate source_illiad:install`. This will prompt you for the necessariy values.

You can manually configure the Illiad source drive in `config/source_illiad.rb`:

    number_of_days_to_poll: 14

    db:
      adapter:    'sqlserver'
      dataserver: ''
      username:   ''
      password:   ''

    webcirc:
      url:      'http://HOSTNAME/illiad/WebCirc/Logon.aspx'
      username: ''
      password: ''

`dataserver` is the name for your server as defined in freetds.conf. `number_of_days_to_poll` is how many days you want to poll into the past. This number must be greater than how often you run Nostos in order to stay synchronized. I recommend polling 2-3 days in the past at most. Your WebCirc URL may be different, though the above should hold true for most OCLC hosted servers.

The `db` variable will actually be passed directly to `ActiveRecord#establish_connection` so you can define any additional parameters as necessary.

# Author

Nostos was written by [Brice Stacey](https://github.com/bricestacey)

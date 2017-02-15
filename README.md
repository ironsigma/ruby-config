# Config

Global configuration class.

## Usage

Searches from the current directory backwards for an environment file.
File is named `.env` by default but can be overriden by environment variable:

```
ENV_VARS=my-env-vars
```

Config file is just key value pairs:

```
# Envrionment
RACK_ENV=development

# Language
LANG=en_US
```

Class usage:

```ruby
# Search and load config file
HawkPrime::Config.load

# To string
HawkPrime::Config.to_s

# Get value
env = HawkPrime::Config[:rack_env]

# If value not found in `.env` file, then process environment is queried.
user_home = HawkPrime::Config[:home] # returns $HOME
user_home = HawkPrime::Config['home'] # also returns $HOME
user_home = HawkPrime::Config['HOME'] # also returns $HOME

# Set config value and ENV[] as well
HawkPrime::Config[:lang] = 'en_US.UTF-8'

# Check for variable
HawkPrime::Config.var? :mongodb_uri

# Config can also be used to register services/object/globals in a clean way
HawkPrime::Config.register :mongodb, Mongo::Client.new('mongodb://127.0.0.1:27017/test').database

# Then access them later
orders = HawkPrime::Config.mongodb[:orders].find()

# Check if something is registered
HawkPrime::Config.registered? :logger

```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'config', :git => "git://github.com/hawkprime/ruby-config.git"

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install config

## Release Notes

### 1.0.0
    * Initial version

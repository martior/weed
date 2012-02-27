# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Weed::Application.initialize!



#add to heroku with heroku config:add TWOAUTH_CALLBACK=http://weed.tw
#add to local machine in ~/.profile with export TWOAUTH_CALLBACK=http://weed.tw
TWOAUTH_CALLBACK = ENV['TWOAUTH_CALLBACK']
# Twitter OAuth Consumer key
TWOAUTH_KEY = ENV['TWOAUTH_KEY']
# Twitter OAuth Consumer secret
TWOAUTH_SECRET = ENV['TWOAUTH_SECRET']

WANTED_KEYS = %w[id screen_name name following]

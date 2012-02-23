require 'oauth/consumer'

class HomeController < ApplicationController

  def index
    @consumer=OAuth::Consumer.new( TWOAUTH_KEY,TWOAUTH_SECRET, {
        :site=>"https://api.twitter.com/"
        })
    @request_token=@consumer.get_request_token( :oauth_callback => TWOAUTH_CALLBACK )
    redirect_to @request_token.authorize_url
    
  end
  
  def callback
    print "callback"
  end

end
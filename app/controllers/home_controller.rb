require 'oauth/consumer'

class HomeController < ApplicationController

  def index
    @consumer=OAuth::Consumer.new( "UB1afSZlv5MIDwyFWNMoLQ","zqxA10TfL55N60tG2G8FeK19DOKbCWTrBRcLOPoDaI", {
        :site=>"https://api.twitter.com/"
        })
    @request_token=@consumer.get_request_token
    redirect_to @request_token.authorize_url
    
  end
  
  def callback
    print "callback"
  end

end
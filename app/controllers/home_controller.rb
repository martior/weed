require 'oauth/consumer'

class HomeController < ApplicationController

  def get_consumer
    return OAuth::Consumer.new( TWOAUTH_KEY,TWOAUTH_SECRET, {
        :site=>"https://api.twitter.com/"
        })
  end


  def get_access_token
    request_token = OAuth::RequestToken.new(get_consumer, session[:oauth_token], session[:oauth_secret])
    return request_token.get_access_token
    #rescue
		#flash[:error] = "Twitter login failure"
		#redirect_to root_url
  end
  
  def verify_credentials
    return ActiveSupport::JSON.decode(get_access_token.get("https://api.twitter.com/1/account/verify_credentials.json").body)
  end

  def index
    user = verify_credentials
    
  rescue
    consumer = get_consumer
    request_token=consumer.get_request_token( :oauth_callback => TWOAUTH_CALLBACK )
    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end


  
  def callback
    request_token = OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
    session[:oauth_token] = params[:oauth_token]
    access_token = request_token.get_access_token
    json = ActiveSupport::JSON.decode(access_token.get("https://api.twitter.com/1/account/verify_credentials.json").body)
    puts json
    session[:twitter_id] = json[:id_str]
    session[:twitter_username] = json[:screen_name]
    session[:name] = json[:name]  
    redirect_to index
  end

end
require 'oauth/consumer'

module OauthTwitter
  def get_consumer
    return OAuth::Consumer.new( TWOAUTH_KEY,TWOAUTH_SECRET, {
        :site=>"https://api.twitter.com/"
        })
  end


  def get_access_token
    return OAuth::AccessToken.new(get_consumer, session[:access_token], session[:access_token_secret])
  end
  
  def verify_credentials
    return ActiveSupport::JSON.decode(get_access_token.get("https://api.twitter.com/1/account/verify_credentials.json").body)
  end

  def login
    request_token=get_consumer.get_request_token( :oauth_callback => TWOAUTH_CALLBACK )
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
    
  end

  
  def callback
    request_token = OAuth::RequestToken.new(get_consumer,  params[:oauth_token], session[:request_token_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier] )
    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret    
    redirect_to :action => :index
  end

  
end

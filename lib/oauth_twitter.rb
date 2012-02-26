require 'oauth/consumer'

module OauthTwitter
  def get_consumer
    return OAuth::Consumer.new( TWOAUTH_KEY,TWOAUTH_SECRET, {
        :site=>"https://api.twitter.com/"
        })
  end


  def get_access_token
    return OAuth::AccessToken.new(get_consumer, session[:access_token], session[:access_token_secret])
	rescue => err
		puts "Exception when getting access token: #{err}"
		raise err

  end
  
  def verify_credentials
		response = get_access_token.get('/account/verify_credentials.json')
		case response
		when Net::HTTPSuccess
			twitter_user=JSON.parse(response.body)
			raise "Twitter user is not a hash"  unless twitter_user.is_a? Hash
      return twitter_user
		else
			raise "Error with http request"
		end
	rescue => err
		puts "User not logged in: #{err}"
    return nil
  end


  def get_friends
    # have to have the full URL of api.twitter.com here to force https.
		response = get_access_token.get('https://api.twitter.com/1/friends/ids.json?cursor=-1')
		case response
		when Net::HTTPSuccess
			friends=JSON.parse(response.body)
			raise "Twitter user is not a hash"  unless friends.is_a? Hash
      friends_array = Array.new(friends["ids"].size)

      friends["ids"].each_with_index {|friend,i|
        friends_array[i]={"id"=> friend, "screen_name"=> "fetching..."}
      }
      return friends_array
		else
			raise "Error with http request"
		end
	rescue => err
		puts "User not logged in: #{err}"
    return nil
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

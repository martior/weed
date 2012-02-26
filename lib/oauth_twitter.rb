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
      return friends["ids"]
		else
			raise "Error with http request"
		end
	rescue => err
		puts "User not logged in: #{err}"
    return nil
  end


  def get_friends_details_from_server(ids)
    friend_ids = ids.join ","
    # have to have the full URL of api.twitter.com here to force https.
		response = get_access_token.get('https://api.twitter.com/1/users/lookup.json?user_id='<<friend_ids)
		case response
		when Net::HTTPSuccess
			friends=JSON.parse(response.body)
			raise "Twitter user details is not an array"  unless friends.is_a? Array
      return friends
		else
      puts response.inspect
			raise "Error with http request"
		end
    rescue => err
		  puts "User not logged in: #{err}"
      return nil
  end
  
  def destroy_friendship(id)
		response = get_access_token.post('https://api.twitter.com/1/friendships/destroy.json',{"user_id"=>id})
    Rails.cache.delete(id)
		case response
		when Net::HTTPSuccess
      return true
		else
      puts response.inspect
			raise "Error with http request"
		end
  rescue => err
		  puts "Error deleting user: #{err}"
      return false

  end
  

  def get_friends_details(ids=get_friends)
    friends = Array.new
    friends_not_cached = Array.new
    ids.each do|id|
        friend_details = Rails.cache.read(id.to_s)
        unless friend_details.nil?
          friends << friend_details
        else
          friends_not_cached << id
        end
    end
    wanted_keys = %w[id screen_name profile_image_url name]
    if friends_not_cached.size > 0
      (0..friends_not_cached.size/100).each do|page|
        get_friends_details_from_server(friends_not_cached[100*page,100]).each do|friend_details|
          friend_details = friend_details.reject { |key,_| !wanted_keys.include? key }
          friends << friend_details
          Rails.cache.write(friend_details["id"].to_s,friend_details)
        end
      end
    end
    return friends
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

require 'oauth_twitter'

class FriendsController < ApplicationController
  include OauthTwitter

  def index
    render :json => get_friends_details
  end
  
  def show
    render :json => get_friends_details([params[:id]])
  end
  
  def destroy
    render :json => destroy_friendship(params[:id])
  end
    
  
end

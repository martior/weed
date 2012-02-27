require 'oauth_twitter'
class ApplicationController < ActionController::Base
  protect_from_forgery
  include OauthTwitter

  def index
    @twitter_user = verify_credentials
    if @twitter_user.nil?
      render :template => 'application/welcome'
    else
      @friends = get_friends_details
    end
  end
  
end

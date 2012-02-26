require 'oauth_twitter'

class HomeController < ApplicationController
  include OauthTwitter

  def index
    @twitter_user = verify_credentials
    if @twitter_user.nil?
        render :template => 'home/welcome'
    else
      
      @friends = get_friends_details
    end
  end

end
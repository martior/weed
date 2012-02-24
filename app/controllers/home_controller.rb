require 'oauth_twitter'

class HomeController < ApplicationController
  include OauthTwitter

  def index
    @twitter_user = verify_credentials
    unless @twitter_user
      login
    end
  end

end
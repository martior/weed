require 'oauth_twitter'

class SearchController < ApplicationController
  include OauthTwitter
  def index
    @twitter_user = verify_credentials
    if @twitter_user.nil?
      redirect_to :controller => 'application', :action => :index
    end
    @q = params[:q]
    @new_friends = search_users(URI.escape(@q))
  end
end

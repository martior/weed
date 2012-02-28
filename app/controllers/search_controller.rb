require 'oauth_twitter'

class SearchController < ApplicationController
  include OauthTwitter
  def index
    @twitter_user = verify_credentials
    if @twitter_user.nil?
      redirect_to :controller => 'application', :action => :index
    end
    @q = params[:q]
    @page = params[:page]
    if @page.nil?
      @page = 0
    else
      @page = @page.to_i
    end
    @page_max = params[:page_max]
    if @page_max.nil?
        @page_max = 0
    else
      @page_max= @page_max.to_i
    end
    if @page > 0
      @previous = @page -1
    else
      @previous = 0
    end
    if @page < @page_max
      @next = @page  + 1
    else
      @next = @page_max
    end
    if @page > @page_max
      @page_max = @page
    end
    @new_friends = search_users(URI.escape(@q),@page)
    if @new_friends.size >= 20
      @more = true
      if @next == @page_max
        @next += 1
      end
    else
      @more = false
    end
  end
end

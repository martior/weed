class Weed.Routers.FriendsRouter extends Backbone.Router
  initialize: (options) ->
    @friends = new Weed.Collections.FriendsCollection()
    @friends.reset options.friends

  routes:
    "/index"    : "index"
    "/page/:page"    : "show_page"
    ".*"        : "index"

  index: ->
    @view = new Weed.Views.Friends.IndexView(friends: @friends)
    $("#friends").html(@view.render().el)

  show_page: (page) ->
    @view = new Weed.Views.Friends.IndexView(friends: @friends)
    page = (Number) page
    if page > Math.floor((@view.options.friends.length/@view.PAGE_SIZE)+1)
      page = Math.floor((@view.options.friends.length/@view.PAGE_SIZE)+1)
    if page < 1
      page = 1
    @view.page = page
    $("#friends").html(@view.render().el)
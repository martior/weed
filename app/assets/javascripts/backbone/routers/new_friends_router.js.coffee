class Weed.Routers.NewFriendsRouter extends Backbone.Router
  initialize: (options) ->
    @newFriends = new Weed.Collections.NewFriendsCollection()
    @newFriends.reset options.newFriends

  routes:
    "/index"    : "index"
    "/page/:page"    : "show_page"
    ".*"        : "index"


  index: ->
    @view = new Weed.Views.NewFriends.IndexView(newFriends: @newFriends)
    $("#new_friends").html(@view.render().el)

  show_page: (page) ->
    @view = new Weed.Views.NewFriends.IndexView(newFriends: @newFriends)
    page = (Number) page
    console.log page
    if page > Math.floor((@view.options.newFriends.length/@view.PAGE_SIZE)+1)
      page = Math.floor((@view.options.newFriends.length/@view.PAGE_SIZE)+1)
    if page < 1
      page = 1
    @view.page = page
    $("#friends").html(@view.render().el)

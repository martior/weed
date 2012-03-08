class Weed.Routers.FriendsRouter extends Backbone.Router
  initialize: (options) ->
    @friends = new Weed.Collections.FriendsCollection()
    @friends.reset options.friends

  routes:
    "/index"    : "index"
    ".*"        : "index"

  index: ->
    @view = new Weed.Views.Friends.IndexView(friends: @friends)
    $("#friends").html(@view.render().el)
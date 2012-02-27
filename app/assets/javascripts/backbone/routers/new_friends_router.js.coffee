class Weed.Routers.NewFriendsRouter extends Backbone.Router
  initialize: (options) ->
    @newFriends = new Weed.Collections.NewFriendsCollection()
    @newFriends.reset options.newFriends

  routes:
    "/index"    : "index"
    ".*"        : "index"


  index: ->
    @view = new Weed.Views.NewFriends.IndexView(newFriends: @newFriends)
    $("#new_friends").html(@view.render().el)


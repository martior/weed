class Weed.Routers.FriendsRouter extends Backbone.Router
  initialize: (options) ->
    @friends = new Weed.Collections.FriendsCollection()
    @friends.reset options.friends

  routes:
    "/new"      : "newFriend"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newFriend: ->
    @view = new Weed.Views.Friends.NewView(collection: @friends)
    $("#friends").html(@view.render().el)

  index: ->
    @view = new Weed.Views.Friends.IndexView(friends: @friends)
    $("#friends").html(@view.render().el)

  show: (id) ->
    friend = @friends.get(id)

    @view = new Weed.Views.Friends.ShowView(model: friend)
    $("#friends").html(@view.render().el)

  edit: (id) ->
    friend = @friends.get(id)

    @view = new Weed.Views.Friends.EditView(model: friend)
    $("#friends").html(@view.render().el)

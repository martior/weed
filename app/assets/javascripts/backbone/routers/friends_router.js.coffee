class Weed.Routers.FriendsRouter extends Backbone.Router
  initialize: (options) ->
    @friends = new Weed.Collections.FriendsCollection()
    @friends.reset options.friends

  routes:
    "/new"      : "newFriend"
    "/index"    : "index"
    "/page/:page"    : "show_page"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newFriend: ->
    @view = new Weed.Views.Friends.NewView(collection: @friends)
    $("#friends").html(@view.render().el)

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


  show: (id) ->
    friend = @friends.get(id)
    @view = new Weed.Views.Friends.ShowView(model: friend)
    $("#friends").html(@view.render().el)

  edit: (id) ->
    friend = @friends.get(id)

    @view = new Weed.Views.Friends.EditView(model: friend)
    $("#friends").html(@view.render().el)

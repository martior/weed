Weed.Views.NewFriends ||= {}

class Weed.Views.NewFriends.IndexView extends Backbone.View
  template: JST["backbone/templates/new_friends/index"]

  initialize: () ->
    @options.newFriends.bind('reset', @addAll)

  addAll: () =>
    @options.newFriends.each(@addOne)

  addOne: (newFriend) =>
    view = new Weed.Views.NewFriends.NewFriendView({model : newFriend})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(newFriends: @options.newFriends.toJSON() ))
    @addAll()

    return this

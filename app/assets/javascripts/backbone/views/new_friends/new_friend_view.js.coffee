Weed.Views.NewFriends ||= {}

class Weed.Views.NewFriends.NewFriendView extends Backbone.View
  template: JST["backbone/templates/new_friends/new_friend"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

Weed.Views.Friends ||= {}

class Weed.Views.Friends.ShowView extends Backbone.View
  template: JST["backbone/templates/friends/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

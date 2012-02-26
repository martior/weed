Weed.Views.Friends ||= {}

class Weed.Views.Friends.EditView extends Backbone.View
  template : JST["backbone/templates/friends/edit"]

  events :
    "submit #edit-friend" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (friend) =>
        @model = friend
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

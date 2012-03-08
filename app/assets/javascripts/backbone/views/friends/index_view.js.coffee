Weed.Views.Friends ||= {}

class Weed.Views.Friends.IndexView extends Backbone.View
  template: JST["backbone/templates/friends/index"]

  events:
    "click .destroy_selected" : "destroy"


  initialize: () ->
    @options.friends.bind('reset', @addAll)

  addAll: () =>
    @options.friends.each(@addOne)


  destroy: () ->
    @$('input:checkbox:checked').each (index, element) =>
      @options.friends.get($(element).val()).destroy()
    @render()
    return false


  addOne: (friend) =>
    view = new Weed.Views.Friends.FriendView({model : friend})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(friends: @options.friends.toJSON()))
    @addAll()
    return this

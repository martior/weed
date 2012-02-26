Weed.Views.Friends ||= {}

class Weed.Views.Friends.IndexView extends Backbone.View
  template: JST["backbone/templates/friends/index"]
  PAGE_SIZE: 20
  page: 1

  events:
    "click .destroy_selected" : "destroy"


  initialize: () ->
    @options.friends.bind('reset', @addAll)

  addAll: () =>
    page = new Weed.Collections.FriendsCollection(@options.friends.rest(@PAGE_SIZE*(@page-1))[0..@PAGE_SIZE-1])
    page.each(@addOne)


  destroy: () ->
    @$('input:checkbox:checked').each (index, element) =>
      @options.friends.get($(element).val()).destroy()
    @render()
    return false


  addOne: (friend) =>
    view = new Weed.Views.Friends.FriendView({model : friend})
    @$("tbody").append(view.render().el)

  render: =>
    pages = Math.floor((@options.friends.length/@PAGE_SIZE)+1)
    if @page >= pages
      next = @page
    else
      next = @page + 1
    if @page <= 1
      previous = @page
    else
      previous = @page - 1
    

    $(@el).html(@template(friends: @options.friends.toJSON(),page: @page, pages:  pages, previous: previous, next: next  ))
    @addAll()
    return this

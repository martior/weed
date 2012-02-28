Weed.Views.NewFriends ||= {}

class Weed.Views.NewFriends.IndexView extends Backbone.View
  template: JST["backbone/templates/new_friends/index"]
  PAGE_SIZE: 20
  page: 1

  initialize: () ->
    @options.newFriends.bind('reset', @addAll)

  addAll: () =>
    page = new Weed.Collections.NewFriendsCollection(@options.newFriends.rest(@PAGE_SIZE*(@page-1))[0..@PAGE_SIZE-1])
    page.each(@addOne)

  addOne: (newFriend) =>
    view = new Weed.Views.NewFriends.NewFriendView({model : newFriend})
    @$("tbody").append(view.render().el)

  render: =>
    pages = Math.floor((@options.newFriends.length/@PAGE_SIZE)+1)
    if @page >= pages
      next = @page
    else
      next = @page + 1
    if @page <= 1
      previous = @page
    else
      previous = @page - 1
    $(@el).html(@template(newFriends: @options.newFriends.toJSON(),page: @page, pages:  pages, previous: previous, next: next  ))
    @addAll()

    return this

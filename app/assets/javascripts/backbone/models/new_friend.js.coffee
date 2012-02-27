class Weed.Models.NewFriend extends Backbone.Model
  paramRoot: 'new_friend'

  defaults:
    id: null
    name: null
    screen_name: null

class Weed.Collections.NewFriendsCollection extends Backbone.Collection
  model: Weed.Models.NewFriend
  url: '/new_friends'

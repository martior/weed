class Weed.Models.Friend extends Backbone.Model
  paramRoot: 'friend'

  defaults:
    id: null
    screen_name: null

class Weed.Collections.FriendsCollection extends Backbone.Collection
  model: Weed.Models.Friend
  url: '/friends'

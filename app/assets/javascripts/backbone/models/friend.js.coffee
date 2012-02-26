class Weed.Models.Friend extends Backbone.Model
  paramRoot: 'friend'

  defaults:
    id: null
    screen_name: null
	name: null
	profile_image_url: null
	

class Weed.Collections.FriendsCollection extends Backbone.Collection
  model: Weed.Models.Friend
  url: '/friends'

Weed.tw
=======

Weed.tw is a tool to weed out the weeds from your twitter timeline. Weed.tw allows you to unfollow in bulk. If your timeline is getting out of hand this tool is for you. When you are done weeding, weed.tw has a built in search to help you find new people to follow.

Weed.tw does not have a database and will not store any personal information. All data needed for the authentication against twitter is stored in your web browser and will be removed when you restart your web browser.

Weed.tw is a web-application written in Ruby on Rails with backbone.js. 

Try it out on http://weed.tw

Getting Started
---------------

1. Register a new application on http://dev.twitter.com
2. Add the following to your ~/.profile (remember to source it after adding it) or just run in terminal before you start rails:

    <pre>export TWOAUTH_CALLBACK=http://localhost:3000/callback
    export TWOAUTH_KEY=<KEY>
    export TWOAUTH_SECRET=<SECRET></pre>

3. Start rails with rails s
4. Go to http://localhost:3000 in your web-browser


Todo
----

* Do crossbrowser testing!!!! so far only tested Safari

* Add more checks and allerts for all functions in oauth_twitter.rb

* Add feedback when unfollowing users, restore model if unsuccessfull

* Add popower with more info about users when clicking on them

* Refactor pagination code to be less of a gigantic mess

* Store max-pages for search result in session? back button can now make the number of pages go down
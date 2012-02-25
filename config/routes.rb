Weed::Application.routes.draw do
  match 'login/' => 'home#login'
  match 'callback/' => 'home#callback'
  root :to => 'home#index'
end

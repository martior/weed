Weed::Application.routes.draw do
  match 'login/' => 'home#login'
  match 'callback/' => 'home#callback'
  match 'logout/' => 'home#logout'
  resources :friends
  root :to => 'home#index'
end

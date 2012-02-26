Weed::Application.routes.draw do
  match 'login/' => 'home#login'
  match 'callback/' => 'home#callback'
  resources :friends
  root :to => 'home#index'
end

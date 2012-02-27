Weed::Application.routes.draw do
  match 'login/' => 'application#login'
  match 'callback/' => 'application#callback'
  match 'logout/' => 'application#logout'
  resources :friends
  root :to => 'application#index'
end

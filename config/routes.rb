Weed::Application.routes.draw do
  match 'weed/' => 'home#index'
  match 'callback/' => 'home#callback'
  root :to => 'home#index'
end

Rails.application.routes.draw do
  resources :microposts
  # :users -- this is an example of a symbol
  resources :users
  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

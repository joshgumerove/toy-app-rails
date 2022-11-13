Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/help'
  get '/about', to: "static_pages#about"
  get '/contact', to: "static_pages#contact"
  get '/help', to: "static_pages#help"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  get 'users/:id', to: "users#destroy"
  resources :microposts
  # :users -- this is an example of a symbol
  resources :users
  get '/users', to: 'users#index'
  get '/signup', to: 'users#new'
  get '/users/:id/edit', to: 'users#edit'
  patch '/users/:id', to: 'users#update' #take not of the restful routing
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

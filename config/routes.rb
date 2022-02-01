Rails.application.routes.draw do
  devise_for :users
  resources :widgets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "users#index"
  root 'users#index'
  get "/user", to: "users#index"
  get "/users/:id", to: "users#show", as: "user_show"
  get "/users/:id/posts", to: "posts#index", as: "all_posts" 
  get "/users/:user_id/posts/:post_id", to: "posts#show", as: "posts_show"
  get "/users/:user_id/post/new", to: "posts#new", as: "new_posts"
  post '/users/:user_id/post/create', to: 'posts#create', as: "create_post"
  delete '/users/:user_id/post/:id/destroy', to: 'posts#destroy', as: "destroy_post"
  get '/users/:user_id/post/:id/comments/new', to: "comments#new", as: "new_comment"
  post '/users/:user_id/post/:id/comments/create', to: 'comments#create', as: "create_comment"
  get '/users/:user_id/post/:id/likes', to: 'likes#create', as: "create_like"
  # Defines the root path route ("/")
  # root "articles#index"
end

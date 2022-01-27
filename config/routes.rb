Rails.application.routes.draw do
  resources :widgets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "users#index"
  root 'users#index'
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show", as: "user_show"
  get "/users/:id/posts", to: "posts#index", as: "all_posts" 
  get "/users/:user_id/posts/:post_id", to: "posts#show", as: "posts_show"
  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"

  devise_for :users
  resources :users, only: [:index,:show,:edit,:update]

  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy] 
   get "relationship/follow_users" => "relationships#follow_users"
   get "relationship/follower_users" => "relationships#follower_users"
   
  get "/search" => "searches#search"

end

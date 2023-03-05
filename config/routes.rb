Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: "homes#top"
  get "home/about"=>"homes#about",as:"about"
  get "search" => "searches#search"
  get "search_book" => "tag_searches#search"
  resources :chats, only: [:show,:create]

  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create,:destroy]
    resource :event_notices, only: [:new,:create,]
    get "event_notices" => "event_notices#sent"
  end

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get "followings" => "relationships#followings",as:"followings"
    get "followers" => "relationships#followers",as:"followers"
    get "daily_posts" => "users#daily_posts"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

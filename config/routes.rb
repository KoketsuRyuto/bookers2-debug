Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/edit'
  get 'index/show'
  get 'index/edit'
  get 'chats/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about",as:"about"
  get "search" => "searches#search"
  resources :chats, only: [:show,:create]
  
  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create,:destroy]
    resource :event_notices, only: [:new,:create,]
    get 'event_notices' => 'event_notices#sent'
  end

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings',as:"followings"
    get 'followers' => 'relationships#followers',as:"followers"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

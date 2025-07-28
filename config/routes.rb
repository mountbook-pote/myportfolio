Rails.application.routes.draw do
  get 'posts/index'
  root 'homes#top'

  # home
  get 'homes/top'

  # users
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_login', to: 'users/sessions#guest_login'
  end
  resources :users, only: [:show]

  #departments
  resources :departments, only: [:show]

  #posts
  resources :posts

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

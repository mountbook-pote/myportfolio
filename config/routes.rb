Rails.application.routes.draw do
  get 'posts/index'
  root 'homes#top'

  # home
  get 'top', to: 'homes#top'
  get 'terms', to: 'homes#terms'
  get 'policy', to: 'homes#policy'

  # users
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_login', to: 'users/sessions#guest_login'
  end
  resources :users, only: :show do
    member do
      get :favorites
    end
  end

  #departments
  resources :departments, only: :show

  #posts
  resources :posts do
    resource :favorite, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

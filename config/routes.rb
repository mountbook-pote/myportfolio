Rails.application.routes.draw do
  root 'homes#top'

  # home
  get 'top', to: 'homes#top'
  get 'about', to: 'homes#about'
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
      delete :delete_icon
    end
  end

  # posts
  get 'posts/index'
  resources :posts do
    resource :favorite, only: [:create, :destroy]
  end

  # departments
  resources :departments, only: :show

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root 'homes#top'

  # home
  get 'homes/top'

  # user
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_login', to: 'users/sessions#guest_login'
  end
  resources :users, only: [:show]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

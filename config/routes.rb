Rails.application.routes.draw do

  get 'messages/index'

  # root
  root 'home#index'

  # authentication
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  # current logged user

  resources :users do
    resources :messages do

    end
  end
end

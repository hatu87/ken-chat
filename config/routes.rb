Rails.application.routes.draw do
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
      get 'sent', to: 'messages#sent', on: :collection
    end

    resources :friends
  end
end

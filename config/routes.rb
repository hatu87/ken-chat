Rails.application.routes.draw do
  get 'blocks/create'

  # root
  root 'home#index'

  # authentication
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'auth/:provider/callback' => 'sessions#callback'

  # current logged user

  resources :users do
    resources :messages do
      get 'sent', to: 'messages#sent', on: :collection
      post 'notify_message_read', to: 'messages#notify_message_read'
    end

    resources :friends
    resources :blocks
  end
end

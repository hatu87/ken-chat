Rails.application.routes.draw do

  # root
  root 'home#index'

  # authentication
  resources :sessions do
    collection do
      # get 'login', to: 'sessions#new'
      # post 'login', to: 'session#create'
    end
  end

  # get 'register', to: 'sessions#register'

  resources :users do
  end
end

Rails.application.routes.draw do

  get 'messages/index'

  # root
  root 'home#index'

  # authentication
  resources :sessions do
    collection do
    end
  end

  resources :users do
    resources :messages
  end
end

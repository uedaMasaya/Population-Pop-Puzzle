Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  
  root 'home#index'
  
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'contact', to: 'contacts#new'
  
  resources :contacts, only: [:new, :create]
  resource :profile, only: :show, controller: 'users'

  get 'question', to: 'questions#show'
  post 'result', to: 'questions#result'
end
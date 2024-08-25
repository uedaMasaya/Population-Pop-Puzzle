Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
  end
  
  root 'home#index'
  
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'contact', to: 'contacts#new'
  
  resources :contacts, only: [:new, :create]

  resources :questions, only: [:index, :show, :result] do
    collection do
      post 'result'
    end
  end
end
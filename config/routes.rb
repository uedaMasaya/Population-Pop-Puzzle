Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  devise_for :users
  root 'home#index'
  
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'contact', to: 'contacts#new'
  
  resources :contacts, only: [:new, :create]
  
  # 他のルート設定
end
Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  # 利用規約ページのルート
  get 'terms', to: 'static_pages#terms', as: 'terms'
  
  # プライバシーページのルート
  get 'privacy', to: 'static_pages#privacy', as: 'privacy'
  
  # お問い合わせページのルート
  get 'contact', to: 'static_pages#contact', as: 'contact'
  
  # 他のルート設定
end
Rails.application.routes.draw do
  
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"

  get "goods/:name" => "home#goods"

  resources :order_items, :orders
  resource :carts, only: [:show]
  
end

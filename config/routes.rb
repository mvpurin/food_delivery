Rails.application.routes.draw do
  devise_for :users

  get 'order_items/create'
  post 'order_items/create'

  resources :categories, only: [:index, :show]
  resources :orders, only: [:show, :edit, :update] do
    patch 'pay', on: :member
  end

  namespace :admin do
    resources :categories do
      resources :items, shallow: true
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root "categories#index"
end

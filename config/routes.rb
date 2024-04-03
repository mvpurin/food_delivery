Rails.application.routes.draw do
  devise_for :delivery_people
  devise_for :users

  get 'users/previous_orders'
  
  get 'order_items/create'
  post 'order_items/create'

  resources :categories, only: [:index, :show]

  resources :orders, only: [:show, :edit, :update] do
    patch 'pay', on: :member
  end

  resources :users, only: [] do
    get 'previous_orders', on: :member
  end

  namespace :admin do
    resources :categories do
      resources :items, shallow: true
    end
  end

  namespace :delivery_person do
    resources :orders, only: [:index] do
      patch 'complete', on: :member
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root "categories#index"
end

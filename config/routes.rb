Rails.application.routes.draw do
  resources :categories do
    resources :items, shallow: true
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  # Головна сторінка - список книг
  root 'books#index'

  # Web маршрути
  resources :books
  resources :authors, only: %i[index show]

  # API v1
  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index show]
      resources :authors, only: %i[index show]
    end
  end

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end

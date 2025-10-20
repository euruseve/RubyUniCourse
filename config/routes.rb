Rails.application.routes.draw do
  # Головна сторінка - список книг
  root 'books#index'

  # RESTful маршрути для книг (CRUD)
  resources :books

  # Reveal health status on /up
  get 'up' => 'rails/health#show', as: :rails_health_check
end

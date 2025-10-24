Rails.application.routes.draw do
  # GraphQL
  post '/graphql', to: 'graphql#execute'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  root 'books#index'

  resources :books
  resources :authors, only: %i[index show]
  resources :imports, only: %i[index new create show]

  # API v1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :books, only: %i[index show]
      resources :authors, only: %i[index show]
    end
  end

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end

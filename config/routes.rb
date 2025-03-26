Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :authentication do
        resources :login, only: :create
        resources :register, only: :create
        resources :me, only: :index
      end

      namespace :products do
        resources :redeem, only: :create
      end

      resources :products, only: %i[index show create update destroy]
      resources :orders, only: %i[create index]
      resources :users, only: %i[index]
    end

    get "/" => "api/main#index", as: :main, only: :index
  end

  namespace :webhook do
    resources :whatsapp, only: :create
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

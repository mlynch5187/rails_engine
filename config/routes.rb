Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items
      resources :merchants
      resources :merchants do
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items
      resources :merchants, except: [:edit, :new]
      resources :merchants, except: [:edit, :new] do
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end

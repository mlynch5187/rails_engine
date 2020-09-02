Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end

      resources :merchants, except: [:edit, :new] do
        get "/items", to: "merchant_items#index"
      end

      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end

      resources :items, except: [:edit, :new] do
        get "/merchant", to: "merchant_items#merchant"
      end
    end
  end
end

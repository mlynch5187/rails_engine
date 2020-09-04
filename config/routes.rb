Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/:merchant_id/revenue", to: "revenue#show"
# most_items is a route that isn't used yet so I would recommend not creating it until you have a test that leads you to making that route
        resources :most_items, only: [:index]
      end

# Since we used the --api flag when creting our project edit and new are not routes that we have to exclude. You could simply use resources :merchants
      resources :merchants, except: [:edit, :new] do
        get "/items", to: "merchant_items#index"
      end

      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end

      resources :items, except: [:edit, :new] do
# This action does not exist in the controller yet, so be sure that you have a test for this route/functionality before it is created
        get "/merchant", to: "merchant_items#merchant"
      end
    end
  end
end

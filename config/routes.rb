Rails.application.routes.drawRails.application.routes.draw do
  get "profile/show"
  get "analytics/index"
  get "categories/index"
  get "categories/show"
  get "categories/new"
  get "categories/edit"

  root "items#index"

  resources :items
  resources :categories

  get "analytics", to: "analytics#index"
  get "profile", to: "profile#show"
  delete "logout", to: "sessions#destroy"

  # API Route (JSON only)
  namespace :api do
    namespace :v1 do

      resources :items do
        collection do
          get :export
          post :import
        end
      end

      resources :categories

    end
  end
end

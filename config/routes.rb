Rails.application.routes.draw do
  # Root — FIRST PAGE
  root "sessions#new"

  # Signup
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # Login / Logout
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Core app pages (after login)
  resources :items
  resources :categories
  resources :audit_logs, only: [:index]

  get "/analytics", to: "analytics#index"
  get "/profile",   to: "profile#show"

  # API
  namespace :api do
    namespace :v1 do
      resources :items do
        collection do
          get  :export
          post :import
        end
      end
      resources :categories
    end
  end
end

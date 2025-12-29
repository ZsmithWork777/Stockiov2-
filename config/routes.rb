Rails.application.routes.draw do
  # Root
  root "sessions#new"

  # Signup
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # Login / Logout
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Core app pages (HTML)
  resources :items do
    collection do
      get  :export
      post :import
    end
  end

  resources :categories
  resources :audit_logs, only: [:index]

  get "/analytics", to: "analytics#index"
  get "/profile",   to: "profile#show"

  # API (JSON ONLY)
  namespace :api do
    namespace :v1 do
      resources :items
      resources :categories
    end
  end
end

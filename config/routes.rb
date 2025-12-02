Rails.application.routes.draw do
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
end

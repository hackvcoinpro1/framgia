Rails.application.routes.draw do

  root "static_pages#home"

  get "/help", to: "static_pages#help"

  get "/about", to: "static_pages#about"

  get "/contact", to: "static_pages#contact"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  get  "/signup",  to: "users#new"

  post "/signup",  to: "users#create"

  resources :users, except: [:create, :destroy, :new]

  namespace :suppervisor do
    resources :users, only: [:create, :destroy, :new]
  end

  resources :courses, only: %i(index show)

end

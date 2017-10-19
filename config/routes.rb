Rails.application.routes.draw do

  root "static_pages#home"

  get "/help", to: "static_pages#help"

  get "/about", to: "static_pages#about"

  get "/contact", to: "static_pages#contact"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  resources :users, except: [:create, :destroy, :new]

  resources :subjects, except: [:create, :destroy, :new]

  namespace :suppervisor do
    resources :users
    resources :subjects
  end

  resources :courses
  resources :course_subjects, only: [:create, :destroy, :update]
  resources :user_courses, only: [:create, :destroy]
end

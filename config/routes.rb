Rails.application.routes.draw do
  get 'task/view'
  resources :structures
  resources :problems
  resources :admin_teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "signup", to: "students#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  resources :students, except: [:new]

  # Defines the root path route ("/")
  root 'admin_teachers#index'

  get 'task(/:id)', to: 'task#view', :as => :task
  get 'tasks/index', to: 'task#index'
end

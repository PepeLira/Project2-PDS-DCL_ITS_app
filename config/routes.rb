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
  get 'task(/:id)/Representacion', to: 'task#represent_step'
  get 'task(/:id)/DCL', to: 'task#dcl_step'
  get 'task(/:id)/Ecuaciones', to: 'task#equation_step'

  get 'problem(/:id)/duplicated', to: 'problems#duplicate', as: 'duplicate'

  resources :responses
  post 'task(/:id)/Ecuaciones', to: 'task#equation_step_post_version'
  
end

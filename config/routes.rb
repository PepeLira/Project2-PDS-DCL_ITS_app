Rails.application.routes.draw do
  get 'task/view'
  resources :structures
  resources :problems
  resources :admin_teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'admin_teachers#index'

  get 'task(/:id)', to: 'task#view'
end

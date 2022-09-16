Rails.application.routes.draw do
  resources :students
  resources :structures
  resources :problems
  resources :admin_teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'admin_teachers#index'
end

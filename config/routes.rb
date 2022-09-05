Rails.application.routes.draw do
  resources :structures
  resources :problems
  resources :admin_teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end

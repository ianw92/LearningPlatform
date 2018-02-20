Rails.application.routes.draw do
  resources :tasks
  resources :todo_lists
  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :lecture_module_contents
  resources :lecture_modules
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'lecture_modules#index'
end

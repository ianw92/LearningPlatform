Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :subtasks do
    post 'complete', on: :member
  end
  resources :tasks do
    post 'complete', on: :member
  end

  resources :todo_lists
  resources :lecture_module_contents
  resources :lecture_modules

  get "/pages/*page" => "pages#show"

  root 'lecture_modules#index'
end

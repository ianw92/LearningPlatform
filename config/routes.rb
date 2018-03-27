Rails.application.routes.draw do
  resources :weeks
  resources :timers
  resources :notes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :subtasks do
    post 'complete', on: :member
  end

  resources :tasks do
    post 'complete', on: :member
    collection do
      post 'sort_by_due_date'
      post 'sort_by_title'
      post 'sort_by_custom'
      patch 'reorder'
    end
  end

  resources :todo_lists
  resources :lecture_module_contents

  resources :lecture_modules do
    post 'add_to_my_modules', on: :member
    post 'remove_from_my_modules', on: :member
  end

  get "/pages/*page" => "pages#show"

  root 'lecture_modules#index'
end

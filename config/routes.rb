Rails.application.routes.draw do
  resources :comments, except: [:show, :index, :new] do
    collection do
      post 'show_comments_toggle'
    end
  end
  resources :timers, only: [:update]
  resources :notes, except: [:show, :index, :edit, :new] do
    collection do
      post 'show_notes_toggle'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :tasks, except: [:index, :show, :new] do
    member do
      post 'complete'
    end
    collection do
      post 'sort_by_due_date'
      post 'sort_by_title'
      post 'sort_by_custom'
      post 'show_completed_toggle'
      patch 'reorder'
    end
  end

  resources :todo_lists, except: [:show]
  resources :lecture_module_contents, except: [:show, :index]

  resources :lecture_modules do
    post 'add_to_my_modules', on: :member
    post 'remove_from_my_modules', on: :member
  end

  get "/pages/*page" => "pages#show"

  root 'lecture_modules#index'
end

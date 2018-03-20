class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_todo_lists

  def set_todo_lists
    if current_user != nil
      # TODO create methods in the models to get these lists
      @todo_lists_global = TodoList.where("user_id = ?", current_user)
      @tasks_global = Task.where(todo_list_id: @todo_lists_global.pluck(:id)).order(:completed).order(:due_date)
      @subtasks_global = Subtask.where(task_id: @tasks_global.ids).order(:completed)
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end

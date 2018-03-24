class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_todo_lists
  before_action :set_previous_page

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def set_todo_lists
    if current_user != nil
      # TODO create methods in the models to get these lists
      @todo_lists_global = TodoList.where("user_id = ?", current_user)
      @tasks_global = Task.where(todo_list_id: @todo_lists_global.pluck(:id)).order(:completed)

      my_sort_style = Profile.find_by(user_id: current_user.id).sort_tasks_by
      if my_sort_style == 'due_date'
        @tasks_global = @tasks_global.order(:due_date)
      elsif my_sort_style == 'title'
        @tasks_global = @tasks_global.order('lower(title)')
      elsif my_sort_style == 2
        @tasks_global = @tasks_global.order(:custom_order)
      end

      @subtasks_global = Subtask.where(task_id: @tasks_global.ids).order(:completed)
    end
  end

  def set_previous_page
    session[:previous_page] = request.env['HTTP_REFERER']
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end

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
      @todo_lists_global = TodoList.get_todo_lists_for_user(current_user)
      @tasks_global = Task.get_tasks_for_lists(@todo_lists_global)

      @my_sort_style = Profile.find_by(user_id: current_user.id).sort_tasks_by
      @tasks_global = Task.sort_tasks(@tasks_global, @my_sort_style)
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

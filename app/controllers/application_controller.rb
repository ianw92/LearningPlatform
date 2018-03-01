class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_todo_lists

  def set_todo_lists
    if current_user != nil
      me = current_user
      my_username = User.find(me.id).username
      @todo_lists_global = TodoList.where("user = ?", my_username)
      @tasks_global = Task.where(todo_list_id: @todo_lists_global.ids).order(:completed).order(:due_date)
    end
  end

end

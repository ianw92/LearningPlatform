class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_todo_lists

  def set_todo_lists
    if current_user != nil
      me = current_user
      my_username = User.find(me.id).username
      # TODO create methods in the models to get these lists
      @todo_lists_global = TodoList.where("user = ?", my_username)
      @tasks_global = Task.where(todo_list_id: @todo_lists_global.ids).order(:completed).order(:due_date)
      @subtasks_global = Subtask.where(task_id: @tasks_global.ids).order(:completed)
    end
  end

end

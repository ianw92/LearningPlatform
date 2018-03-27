class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:edit, :update, :destroy]
  authorize_resource

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @subtasks = Subtask.all

    @task = Task.new
  end

  # GET /todo_lists/new
  def new
    me = current_user
    @todo_list = TodoList.new(user_id: me.id)
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to todo_lists_path, notice: 'Todo list was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to todo_lists_path, notice: 'Todo list was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: 'Todo list was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :user_id)
    end
end

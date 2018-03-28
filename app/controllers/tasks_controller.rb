class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy,]
  authorize_resource

  def reorder
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all(position: index+1)
    end

    head :ok
  end

  def sort_by_due_date
    change_sorting_parameter('due_date')
  end

  def sort_by_title
    change_sorting_parameter('title')
  end

  def sort_by_custom
    change_sorting_parameter('position')
  end

  def complete
    task_to_toggle_completion = Task.find(params[:id])
    task = Task.change_completed_status(task_to_toggle_completion)
    respond_to do |format|
      if task.save
        format.html { redirect_back fallback_location: root_path, notice: 'Task was successfully updated.' }
        format.js { @current_task = task_to_toggle_completion }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_back fallback_location: root_path, notice: 'Task was successfully created.' }
        format.js { @saved_task = @task, @task = Task.new }
      else
        format.html { render "todo_lists/index" }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to todo_lists_path, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:todo_list_id, :title, :due_date, :completed)
    end

    def change_sorting_parameter(new_param)
      profile = Profile.find_by(user_id: current_user.id)
      profile = Profile.change_sort_parameter(profile, new_param)
      respond_to do |format|
        if profile.save
          set_todo_lists
          format.html { redirect_back fallback_location: root_path, notice: 'Profile was successfully updated.' }
          format.js
        else
          format.html { redirect_back fallback_location: root_path, notice: 'Profile could not be updated.' }
        end
      end
    end

end

class AddShowCompletedTasksToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :show_completed_tasks, :boolean
  end
end

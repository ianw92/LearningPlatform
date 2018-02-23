class RemoveDescriptionFromTasks < ActiveRecord::Migration[5.1]
  def self.up
    remove_column :tasks, :description
  end

  def self.down
    add_column :tasks, :description, :string
  end
end

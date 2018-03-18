class RemoveUserFromTodoLists < ActiveRecord::Migration[5.1]
  def self.up
    remove_column :todo_lists, :user
  end

  def self.down
    add_column :todo_lists, :user, :string
  end
end

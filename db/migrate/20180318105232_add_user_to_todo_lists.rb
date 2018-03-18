class AddUserToTodoLists < ActiveRecord::Migration[5.1]
  def self.up
    add_column :todo_lists, :user, :string
  end

  def self.down
    remove_column :todo_lists, :user
  end
end

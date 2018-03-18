class ChangeTodoListsUserFieldToUserId < ActiveRecord::Migration[5.1]
  def change
    add_reference :todo_lists, :user, index: true
    TodoList.all.each do |todo_list|
      todo_list.user_id = 1
      todo_list.save
    end
    remove_column :todo_lists, :user
  end
end

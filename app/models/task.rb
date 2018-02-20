class Task < ApplicationRecord
  belongs_to :todo_list

  validates :title, :due_date, presence: true

  #TODO test this!
  def self.get_tasks_for_list(todo_list)
    list_id = todo_list.id
    Task.where("todo_list_id = ?", list_id)
  end
end

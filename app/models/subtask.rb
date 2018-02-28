class Subtask < ApplicationRecord
  belongs_to :task

  validates :title, :due_date, presence: true

  # TODO Write this validation method
  def subtask_due_date_must_not_be_after_task_due_date

  end



  #TODO test this!
  def self.get_subtasks_for_task(task)
    task_id = task.id
    Subtask.where("task_id = ?", task_id).order(:completed).order(:due_date)
  end

  #TODO test this!
  def self.change_completed_status(subtask)
    if subtask.completed?
      Subtask.update(subtask.id, :completed => false)
    else
      Subtask.update(subtask.id, :completed => true)
    end

    return subtask
  end
end

class Task < ApplicationRecord
  belongs_to :todo_list

  validates :title, :due_date, presence: true
  validates :completed, inclusion: { in: [true, false] }

  def self.get_tasks_for_lists(todo_lists)
    Task.where(todo_list_id: todo_lists.pluck(:id)).order(:completed)
  end

  def self.get_tasks_for_list(todo_list)
    list_id = todo_list.id
    Task.where("todo_list_id = ?", list_id).order(:completed).order(:due_date)
  end

  def self.change_completed_status(task)
    if task.completed?
      Task.update(task.id, :completed => false)
    else
      Task.update(task.id, :completed => true)
    end
    return task
  end

  def self.sort_tasks(tasks, sort_style)
    if sort_style == 'due_date'
      return tasks.order(:due_date)
    elsif sort_style == 'title'
      return tasks.order('lower(title)')
    elsif sort_style == 'position'
      return tasks.order(:position)
    end
  end

  def get_due_status
    today = Date.today
    tomorrow = today + 1.day
    if completed?
      if self.todo_list.user.profile.show_completed_tasks?
        return "_completed task_show"
      else
        return "_completed"
      end
    elsif due_date < today
      return "_overdue"
    elsif due_date == today
      return "_due_today"
    elsif due_date == tomorrow
      return "_due_tomorrow"
    else
      return
    end
  end
end

class Profile < ApplicationRecord
  belongs_to :user

  enum sort_tasks_by: [:due_date, :title, :position]

  validates :sort_tasks_by, presence: true

  def self.change_sort_parameter(profile, new_param)
    Profile.update(profile.id, sort_tasks_by: new_param)
  end

  def change_show_completed_state
    if show_completed_tasks
      Profile.update(self.id, show_completed_tasks: false)
    else
      Profile.update(self.id, show_completed_tasks: true)
    end
  end

  def show_or_hide_button_text
    if show_completed_tasks
      return "Hide Completed"
    else
      return "Show Completed"
    end
  end
end

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

  def change_show_notes_state
    if show_notes
      Profile.update(self.id, show_notes: false)
    else
      Profile.update(self.id, show_notes: true)
    end
  end

  def change_show_comments_state
    if show_comments
      Profile.update(self.id, show_comments: false)
    else
      Profile.update(self.id, show_comments: true)
    end
  end

  def show_or_hide_button_text(type)
    if type == 'tasks'
      if show_completed_tasks
        return "Hide Completed"
      else
        return "Show Completed"
      end
    elsif type == 'notes'
      if show_notes
        return "Hide Notes"
      else
        return "Show Notes"
      end
    elsif type =='comments'
      if show_comments
        return "Hide Discussion"
      else
        return "Show Discussion"
      end
    end
  end

  def get_show_notes_status
    if show_notes
      return
    else
      return "notes_hidden"
    end
  end

  def get_show_comments_status
    if show_comments
      return
    else
      return "comments_hidden"
    end
  end
end

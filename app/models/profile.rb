class Profile < ApplicationRecord
  belongs_to :user

  enum sort_tasks_by: [:due_date, :title, :position]

  validates :sort_tasks_by, presence: true

  def self.change_sort_parameter(profile, new_param)
    Profile.update(profile.id, sort_tasks_by: new_param)
  end
end

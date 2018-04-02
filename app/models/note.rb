class Note < ApplicationRecord
  belongs_to :user
  belongs_to :week

  validates :week, :body, presence: true

  validates :user, uniqueness: { scope: :week, message: 'User/Week pair must be unique' }

  def self.get_notes_for_module_and_user(lecture_module, user)
    weeks = Week.where(lecture_module: lecture_module)
    Note.where("user_id = ?", user).where("week_id IN (?)", weeks.ids)
  end
end

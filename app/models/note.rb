class Note < ApplicationRecord
  belongs_to :user
  belongs_to :week

  validates :week, :body, presence: true

  #TODO write validation method for can only have on notew for each user/module/week combo

  def self.get_notes_for_module_and_user(lecture_module, user)
    weeks = Week.where(lecture_module: lecture_module)
    Note.where("user_id = ?", user).where("week_id IN (?)", weeks.ids)
  end
end

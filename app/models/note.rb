class Note < ApplicationRecord
  belongs_to :user
  belongs_to :lecture_module

  validates :week, :notes, presence: true
  validates :week, numericality: true,
                   inclusion: { within: 1..12 }

  #TODO write validation method for can only have on notew for each user/module/week combo

  def self.get_notes_for_module_and_user(lecture_module, user)
    Note.where("user_id = ?", user).where("lecture_module_id = ?", lecture_module)
  end
end

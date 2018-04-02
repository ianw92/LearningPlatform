class UserModuleLinker < ApplicationRecord
  belongs_to :user
  belongs_to :lecture_module

  validates :user, uniqueness: { scope: :lecture_module, message: 'User/LectureModule pair must be unique' }

  def self.add_new_linker(lecture_module, user)
    UserModuleLinker.new(user: user, lecture_module: lecture_module)
  end

  def self.remove_linker(lecture_module, user)
    UserModuleLinker.where(user: user).where(lecture_module: lecture_module).destroy_all
  end
end

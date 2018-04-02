class UserModuleLinker < ApplicationRecord
  belongs_to :user
  belongs_to :lecture_module

  # TODO validation methods to ensure only one linker exists for a pair of user/module

  def self.add_new_linker(lecture_module, user)
    UserModuleLinker.new(user: user, lecture_module: lecture_module)
  end

  def self.remove_linker(lecture_module, user)
    UserModuleLinker.where(user: user).where(lecture_module: lecture_module).destroy_all
  end
end

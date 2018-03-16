class UserModuleLinker < ApplicationRecord
  belongs_to :user
  belongs_to :lecture_module

  #TODO test this
  def self.add_new_linker(lecture_module, user)
    UserModuleLinker.new(user_id: user.id, lecture_module_id: lecture_module.id)
  end

  #TODO test this
  def self.remove_linker(lecture_module, user)
    UserModuleLinker.where("user_id = ?", user.id).where("lecture_module_id = ?", lecture_module.id).destroy_all
  end
end

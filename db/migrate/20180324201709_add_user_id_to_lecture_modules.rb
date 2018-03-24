class AddUserIdToLectureModules < ActiveRecord::Migration[5.1]
  def change
    add_reference :lecture_modules, :user, foreign_key: true

    LectureModule.all.each do |lecture_module|
      lecture_module.update(user_id: 1)
      lecture_module.save!
    end
  end
end

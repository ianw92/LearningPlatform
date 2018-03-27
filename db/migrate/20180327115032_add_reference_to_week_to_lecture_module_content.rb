class AddReferenceToWeekToLectureModuleContent < ActiveRecord::Migration[5.1]
  def change
    add_reference :lecture_module_contents, :week, foreign_key: true
  end
end

class ChangeDataTypeForSemester < ActiveRecord::Migration[5.1]
  # def up
  #   change_column :lecture_modules, :semester, :string
  #   LectureModule.all.each do |lecture_module|
  #     lecture_module.semester = "ACADEMIC YEAR" if lecture_module.semester == 0
  #     lecture_module.semester = "AUTUMN" if lecture_module.semester == 1
  #     lecture_module.semester = "SPRING" if lecture_module.semester == 2
  #   end
  # end
  #
  # def down
  #   change_column :lecture_modules, :semester, :integer
  #   LectureModule.all.each do |lecture_module|
  #     lecture_module.semester = 0 if lecture_module.semester == "ACADEMIC YEAR"
  #     lecture_module.semester = 1 if lecture_module.semester == "AUTUMN"
  #     lecture_module.semester = 2 if lecture_module.semester == "SPRING"
  #   end
  # end
end

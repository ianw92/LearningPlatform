class AddIndexToLectureModule < ActiveRecord::Migration[5.1]
  def change
    add_index :lecture_modules, [:code, :academic_year_end], unique: true
  end
end

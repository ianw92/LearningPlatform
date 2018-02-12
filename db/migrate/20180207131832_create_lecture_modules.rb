class CreateLectureModules < ActiveRecord::Migration[5.1]
  def change
    create_table :lecture_modules do |t|
      t.string :code
      t.integer :academic_year_end
      t.integer :semester
      t.text :name

      t.timestamps
    end
  end
end

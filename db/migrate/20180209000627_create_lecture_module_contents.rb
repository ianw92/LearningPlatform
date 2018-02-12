class CreateLectureModuleContents < ActiveRecord::Migration[5.1]
  def change
    create_table :lecture_module_contents do |t|
      t.string :code
      t.integer :academic_year_end
      t.integer :week
      t.string :data_source
      t.text :description
      t.belongs_to :lecture_module, foreign_key: true

      t.timestamps
    end
  end
end

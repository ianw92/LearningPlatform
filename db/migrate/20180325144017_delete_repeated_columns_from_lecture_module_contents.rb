class DeleteRepeatedColumnsFromLectureModuleContents < ActiveRecord::Migration[5.1]
  def change
    remove_column :lecture_module_contents, :code
    remove_column :lecture_module_contents, :academic_year_end
  end
end

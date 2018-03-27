class ChangeLectureModuleContentsToUseWeekModelInsteadOfWeekField < ActiveRecord::Migration[5.1]
  def change
    # then remove lecture_module_id reference and week field
    remove_reference :lecture_module_contents, :lecture_module, index: true, foreign_key: true
    remove_column :lecture_module_contents, :week
  end
end

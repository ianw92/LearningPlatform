class RemoveLectureModuleReferenceFromNote < ActiveRecord::Migration[5.1]
  def change
    remove_reference :notes, :lecture_module, index: true, foreign_key: true
  end
end

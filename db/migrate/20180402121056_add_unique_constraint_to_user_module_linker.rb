class AddUniqueConstraintToUserModuleLinker < ActiveRecord::Migration[5.1]
  def change
    add_index :user_module_linkers, [:user_id, :lecture_module_id], :unique => true
  end
end

class RemoveDataSourceFromLectureModuleContents < ActiveRecord::Migration[5.1]
  def self.up
    remove_column :lecture_module_contents, :data_source
  end

  def self.down
    add_column :lecture_module_contents, :data_source, :string
  end
end

class AddContentToLectureModuleContents < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :lecture_module_contents, :content
  end

  def self.down
    remove_attachment :lecture_module_contents, :content
  end
end

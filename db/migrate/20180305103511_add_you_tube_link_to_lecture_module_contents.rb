class AddYouTubeLinkToLectureModuleContents < ActiveRecord::Migration[5.1]
  def change
    add_column :lecture_module_contents, :youTube_link, :string
  end
end

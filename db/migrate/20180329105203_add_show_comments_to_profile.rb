class AddShowCommentsToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :show_comments, :boolean
    Profile.all.each do |profile|
      profile.update(show_comments: true)
    end
  end
end

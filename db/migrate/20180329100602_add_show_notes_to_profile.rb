class AddShowNotesToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :show_notes, :boolean
    Profile.all.each do |profile|
      profile.update(show_notes: true)
    end
  end
end

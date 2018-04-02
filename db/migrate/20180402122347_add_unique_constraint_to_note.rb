class AddUniqueConstraintToNote < ActiveRecord::Migration[5.1]
  def change
    add_index :notes, [:user_id, :week_id], :unique => true
  end
end

class RemoveWeekFieldFromNote < ActiveRecord::Migration[5.1]
  def change
    remove_column :notes, :week, :integer
  end
end

class ChangeNotesColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :notes, :notes, :body
  end
end

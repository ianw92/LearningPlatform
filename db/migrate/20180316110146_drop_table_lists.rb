class DropTableLists < ActiveRecord::Migration[5.1]
  def change
    drop_table :lists
  end
end

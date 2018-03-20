class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.references :user, foreign_key: true
      t.references :lecture_module, foreign_key: true
      t.integer :week
      t.text :notes

      t.timestamps
    end
  end
end

class CreateWeeks < ActiveRecord::Migration[5.1]
  def change
    create_table :weeks do |t|
      t.references :lecture_module, foreign_key: true
      t.integer :week_number

      t.timestamps
    end
  end
end

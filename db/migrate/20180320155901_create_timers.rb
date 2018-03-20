class CreateTimers < ActiveRecord::Migration[5.1]
  def change
    create_table :timers do |t|
      t.references :user, foreign_key: true
      t.integer :study_length
      t.integer :short_break_length
      t.integer :long_break_length

      t.timestamps
    end
  end
end

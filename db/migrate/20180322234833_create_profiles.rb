class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :sort_tasks_by

      t.timestamps
    end
  end
end